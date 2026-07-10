Write-Output "Starting Week 10 Cleanup..."

# 1. EventBridge Rule
Write-Output "Deleting EventBridge Rule..."
aws events remove-targets --rule EC2StateChangeRule --ids "1" 2>$null
aws events delete-rule --name EC2StateChangeRule 2>$null

# 2. Lambda
Write-Output "Deleting Lambda..."
aws lambda delete-function --function-name EC2SlackNotifier 2>$null

# 3. IAM Role
Write-Output "Deleting IAM Role..."
aws iam detach-role-policy --role-name LambdaEC2SlackRole --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole 2>$null
aws iam delete-role --role-name LambdaEC2SlackRole 2>$null

# 4. TGW Attachments
Write-Output "Deleting TGW Attachments..."
$tgws = aws ec2 describe-transit-gateways --query "TransitGateways[*].TransitGatewayId" --output text
$attachments = aws ec2 describe-transit-gateway-vpc-attachments --query "TransitGatewayVpcAttachments[*].TransitGatewayAttachmentId" --output text

if ($attachments -ne "None" -and -not [string]::IsNullOrWhiteSpace($attachments)) {
    foreach ($att in ($attachments -split '\s+')) {
        aws ec2 delete-transit-gateway-vpc-attachment --transit-gateway-attachment-id $att 2>$null
    }
}

Write-Output "Waiting for TGW Attachments to delete (30s)..."
Start-Sleep -Seconds 30

# 5. TGW
Write-Output "Deleting Transit Gateways..."
if ($tgws -ne "None" -and -not [string]::IsNullOrWhiteSpace($tgws)) {
    foreach ($tgw in ($tgws -split '\s+')) {
        aws ec2 delete-transit-gateway --transit-gateway-id $tgw 2>$null
    }
}

Write-Output "Waiting for TGW to delete (30s)..."
Start-Sleep -Seconds 30

# 6. Delete Instances in VPC-C (Lab10-VPC)
Write-Output "Terminating Instance-VPC-C..."
$vpcC = aws ec2 describe-vpcs --filters "Name=tag:Name,Values=Lab10-VPC" --query "Vpcs[0].VpcId" --output text
if ($vpcC -eq "None" -or [string]::IsNullOrWhiteSpace($vpcC)) {
    $vpcC = aws ec2 describe-vpcs --filters "Name=isDefault,Values=true" --query "Vpcs[0].VpcId" --output text
}
$instancesC = aws ec2 describe-instances --filters "Name=vpc-id,Values=$vpcC" "Name=tag:Name,Values=Instance-VPC-C" "Name=instance-state-name,Values=running,stopped,pending" --query "Reservations[*].Instances[*].InstanceId" --output text
if ($instancesC -ne "None" -and -not [string]::IsNullOrWhiteSpace($instancesC)) {
    aws ec2 terminate-instances --instance-ids ($instancesC -split '\s+') | Out-Null
}

# 7. Delete VPC-A and VPC-B
function Cleanup-VPC {
    param([string]$VpcName)
    $VpcId = aws ec2 describe-vpcs --filters "Name=tag:Name,Values=$VpcName" --query "Vpcs[0].VpcId" --output text
    if ($VpcId -eq "None" -or [string]::IsNullOrWhiteSpace($VpcId)) { return }

    Write-Output "Cleaning up dependencies for VPC: $VpcId ($VpcName)"

    # Delete Instances
    $instances = aws ec2 describe-instances --filters "Name=vpc-id,Values=$VpcId" "Name=instance-state-name,Values=running,stopped,pending" --query "Reservations[*].Instances[*].InstanceId" --output text
    if ($instances -ne "None" -and -not [string]::IsNullOrWhiteSpace($instances)) {
        aws ec2 terminate-instances --instance-ids ($instances -split '\s+') | Out-Null
        aws ec2 wait instance-terminated --instance-ids ($instances -split '\s+')
    }

    # Delete Subnets
    $subnets = aws ec2 describe-subnets --filters "Name=vpc-id,Values=$VpcId" --query "Subnets[*].SubnetId" --output text
    if ($subnets -ne "None" -and -not [string]::IsNullOrWhiteSpace($subnets)) {
        foreach ($sub in ($subnets -split '\s+')) {
            aws ec2 delete-subnet --subnet-id $sub 2>$null
        }
    }

    # Detach and Delete IGW
    $igws = aws ec2 describe-internet-gateways --filters "Name=attachment.vpc-id,Values=$VpcId" --query "InternetGateways[*].InternetGatewayId" --output text
    if ($igws -ne "None" -and -not [string]::IsNullOrWhiteSpace($igws)) {
        foreach ($igw in ($igws -split '\s+')) {
            aws ec2 detach-internet-gateway --internet-gateway-id $igw --vpc-id $VpcId 2>$null
            aws ec2 delete-internet-gateway --internet-gateway-id $igw 2>$null
        }
    }

    # Delete Custom Route Tables
    $rtbs = aws ec2 describe-route-tables --filters "Name=vpc-id,Values=$VpcId" "Name=association.main,Values=false" --query "RouteTables[*].RouteTableId" --output text
    if ($rtbs -ne "None" -and -not [string]::IsNullOrWhiteSpace($rtbs)) {
        foreach ($rtb in ($rtbs -split '\s+')) {
            aws ec2 delete-route-table --route-table-id $rtb 2>$null
        }
    }

    # Delete Security Groups (except default)
    $sgs = aws ec2 describe-security-groups --filters "Name=vpc-id,Values=$VpcId" --query "SecurityGroups[?GroupName!='default'].GroupId" --output text
    if ($sgs -ne "None" -and -not [string]::IsNullOrWhiteSpace($sgs)) {
        foreach ($sg in ($sgs -split '\s+')) {
            aws ec2 delete-security-group --group-id $sg 2>$null
        }
    }

    # Delete VPC
    aws ec2 delete-vpc --vpc-id $VpcId 2>$null
}

Cleanup-VPC -VpcName "VPC-A"
Cleanup-VPC -VpcName "VPC-B"

Write-Output "Week 10 Cleanup Complete!"
