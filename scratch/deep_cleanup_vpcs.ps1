function Cleanup-VPC {
    param([string]$VpcId)
    if ($VpcId -eq "None" -or [string]::IsNullOrWhiteSpace($VpcId)) { return }

    Write-Output "Cleaning up dependencies for VPC: $VpcId"

    # Delete Instances
    $instances = aws ec2 describe-instances --filters "Name=vpc-id,Values=$VpcId" "Name=instance-state-name,Values=running,stopped,pending" --query "Reservations[*].Instances[*].InstanceId" --output text
    if ($instances -ne "None" -and -not [string]::IsNullOrWhiteSpace($instances)) {
        Write-Output "Terminating instances: $instances"
        aws ec2 terminate-instances --instance-ids ($instances -split '\s+') | Out-Null
        aws ec2 wait instance-terminated --instance-ids ($instances -split '\s+')
    }

    # Delete Subnets
    $subnets = aws ec2 describe-subnets --filters "Name=vpc-id,Values=$VpcId" --query "Subnets[*].SubnetId" --output text
    if ($subnets -ne "None" -and -not [string]::IsNullOrWhiteSpace($subnets)) {
        foreach ($sub in ($subnets -split '\s+')) {
            Write-Output "Deleting subnet: $sub"
            aws ec2 delete-subnet --subnet-id $sub
        }
    }

    # Detach and Delete IGW
    $igws = aws ec2 describe-internet-gateways --filters "Name=attachment.vpc-id,Values=$VpcId" --query "InternetGateways[*].InternetGatewayId" --output text
    if ($igws -ne "None" -and -not [string]::IsNullOrWhiteSpace($igws)) {
        foreach ($igw in ($igws -split '\s+')) {
            Write-Output "Detaching and deleting IGW: $igw"
            aws ec2 detach-internet-gateway --internet-gateway-id $igw --vpc-id $VpcId
            aws ec2 delete-internet-gateway --internet-gateway-id $igw
        }
    }

    # Delete Custom Route Tables
    $rtbs = aws ec2 describe-route-tables --filters "Name=vpc-id,Values=$VpcId" "Name=association.main,Values=false" --query "RouteTables[*].RouteTableId" --output text
    if ($rtbs -ne "None" -and -not [string]::IsNullOrWhiteSpace($rtbs)) {
        foreach ($rtb in ($rtbs -split '\s+')) {
            Write-Output "Deleting route table: $rtb"
            aws ec2 delete-route-table --route-table-id $rtb | Out-Null
        }
    }

    # Delete Security Groups (except default)
    $sgs = aws ec2 describe-security-groups --filters "Name=vpc-id,Values=$VpcId" --query "SecurityGroups[?GroupName!='default'].GroupId" --output text
    if ($sgs -ne "None" -and -not [string]::IsNullOrWhiteSpace($sgs)) {
        foreach ($sg in ($sgs -split '\s+')) {
            Write-Output "Deleting security group: $sg"
            aws ec2 delete-security-group --group-id $sg
        }
    }

    # Delete VPC
    Write-Output "Deleting VPC: $VpcId"
    aws ec2 delete-vpc --vpc-id $VpcId
}

Cleanup-VPC -VpcId vpc-0c5b8595f3b1aacaa
Cleanup-VPC -VpcId vpc-05ef8c50744e8854a
Cleanup-VPC -VpcId vpc-08f49243da9f25c83
