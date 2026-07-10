Write-Output "Starting Week 9 Deployments..."

# 1. Enable Security Hub
Write-Output "Enabling AWS Security Hub..."
try {
    aws securityhub enable-security-hub --enable-default-standards --tags Key=Environment,Value=Lab18
    Write-Output "Security Hub enabled."
} catch {
    Write-Output "Security Hub might already be enabled. Skipping error."
}

# 2. Create VPC A
Write-Output "Creating VPC A..."
$vpcA = aws ec2 create-vpc --cidr-block 10.0.0.0/16 --query "Vpc.VpcId" --output text
aws ec2 create-tags --resources $vpcA --tags Key=Name,Value="VPC-A"
aws ec2 modify-vpc-attribute --vpc-id $vpcA --enable-dns-hostnames '{\"Value\":true}'

$subnetA = aws ec2 create-subnet --vpc-id $vpcA --cidr-block 10.0.1.0/24 --availability-zone ap-southeast-2a --query "Subnet.SubnetId" --output text
aws ec2 create-tags --resources $subnetA --tags Key=Name,Value="Subnet-A"

$igwA = aws ec2 create-internet-gateway --query "InternetGateway.InternetGatewayId" --output text
aws ec2 attach-internet-gateway --vpc-id $vpcA --internet-gateway-id $igwA

$rtA = aws ec2 describe-route-tables --filters "Name=vpc-id,Values=$vpcA" "Name=association.main,Values=true" --query "RouteTables[0].RouteTableId" --output text
aws ec2 create-route --route-table-id $rtA --destination-cidr-block 0.0.0.0/0 --gateway-id $igwA | Out-Null
aws ec2 create-tags --resources $rtA --tags Key=Name,Value="RT-A"

$sgA = aws ec2 create-security-group --group-name "SG-A" --description "Allow SSH and ICMP" --vpc-id $vpcA --query "GroupId" --output text
aws ec2 authorize-security-group-ingress --group-id $sgA --protocol tcp --port 22 --cidr 0.0.0.0/0 | Out-Null
aws ec2 authorize-security-group-ingress --group-id $sgA --protocol icmp --port -1 --cidr 10.1.0.0/16 | Out-Null

# 3. Create VPC B
Write-Output "Creating VPC B..."
$vpcB = aws ec2 create-vpc --cidr-block 10.1.0.0/16 --query "Vpc.VpcId" --output text
aws ec2 create-tags --resources $vpcB --tags Key=Name,Value="VPC-B"
aws ec2 modify-vpc-attribute --vpc-id $vpcB --enable-dns-hostnames '{\"Value\":true}'

$subnetB = aws ec2 create-subnet --vpc-id $vpcB --cidr-block 10.1.1.0/24 --availability-zone ap-southeast-2b --query "Subnet.SubnetId" --output text
aws ec2 create-tags --resources $subnetB --tags Key=Name,Value="Subnet-B"

$igwB = aws ec2 create-internet-gateway --query "InternetGateway.InternetGatewayId" --output text
aws ec2 attach-internet-gateway --vpc-id $vpcB --internet-gateway-id $igwB

$rtB = aws ec2 describe-route-tables --filters "Name=vpc-id,Values=$vpcB" "Name=association.main,Values=true" --query "RouteTables[0].RouteTableId" --output text
aws ec2 create-route --route-table-id $rtB --destination-cidr-block 0.0.0.0/0 --gateway-id $igwB | Out-Null
aws ec2 create-tags --resources $rtB --tags Key=Name,Value="RT-B"

$sgB = aws ec2 create-security-group --group-name "SG-B" --description "Allow SSH and ICMP" --vpc-id $vpcB --query "GroupId" --output text
aws ec2 authorize-security-group-ingress --group-id $sgB --protocol tcp --port 22 --cidr 0.0.0.0/0 | Out-Null
aws ec2 authorize-security-group-ingress --group-id $sgB --protocol icmp --port -1 --cidr 10.0.0.0/16 | Out-Null

# 4. Launch EC2 Instances
Write-Output "Launching EC2 Instances..."
$amiId = aws ssm get-parameters --names /aws/service/ami-amazon-linux-latest/al2023-ami-kernel-6.1-x86_64 --query "Parameters[0].Value" --output text

$instanceA = aws ec2 run-instances --image-id $amiId --count 1 --instance-type t2.micro --subnet-id $subnetA --security-group-ids $sgA --associate-public-ip-address --query "Instances[0].InstanceId" --output text
aws ec2 create-tags --resources $instanceA --tags Key=Name,Value="Instance-A"

$instanceB = aws ec2 run-instances --image-id $amiId --count 1 --instance-type t2.micro --subnet-id $subnetB --security-group-ids $sgB --associate-public-ip-address --query "Instances[0].InstanceId" --output text
aws ec2 create-tags --resources $instanceB --tags Key=Name,Value="Instance-B"

# 5. Create VPC Peering
Write-Output "Creating VPC Peering Connection..."
$peeringId = aws ec2 create-vpc-peering-connection --vpc-id $vpcA --peer-vpc-id $vpcB --query "VpcPeeringConnection.VpcPeeringConnectionId" --output text
Start-Sleep -Seconds 5
aws ec2 accept-vpc-peering-connection --vpc-peering-connection-id $peeringId | Out-Null
aws ec2 create-tags --resources $peeringId --tags Key=Name,Value="Peering-A-to-B"

# Enable DNS Resolution for Peering
aws ec2 modify-vpc-peering-connection-options --vpc-peering-connection-id $peeringId --requester-peering-connection-options '{\"AllowDnsResolutionFromRemoteVpc\":true}' --accepter-peering-connection-options '{\"AllowDnsResolutionFromRemoteVpc\":true}' | Out-Null

# 6. Add Routes to Route Tables
Write-Output "Adding Routes for Peering..."
aws ec2 create-route --route-table-id $rtA --destination-cidr-block 10.1.0.0/16 --vpc-peering-connection-id $peeringId | Out-Null
aws ec2 create-route --route-table-id $rtB --destination-cidr-block 10.0.0.0/16 --vpc-peering-connection-id $peeringId | Out-Null

Write-Output "vpcA=$vpcA" | Out-File -FilePath scratch/week9_resources.txt
Write-Output "subnetA=$subnetA" | Out-File -FilePath scratch/week9_resources.txt -Append
Write-Output "igwA=$igwA" | Out-File -FilePath scratch/week9_resources.txt -Append
Write-Output "rtA=$rtA" | Out-File -FilePath scratch/week9_resources.txt -Append
Write-Output "sgA=$sgA" | Out-File -FilePath scratch/week9_resources.txt -Append
Write-Output "instanceA=$instanceA" | Out-File -FilePath scratch/week9_resources.txt -Append

Write-Output "vpcB=$vpcB" | Out-File -FilePath scratch/week9_resources.txt -Append
Write-Output "subnetB=$subnetB" | Out-File -FilePath scratch/week9_resources.txt -Append
Write-Output "igwB=$igwB" | Out-File -FilePath scratch/week9_resources.txt -Append
Write-Output "rtB=$rtB" | Out-File -FilePath scratch/week9_resources.txt -Append
Write-Output "sgB=$sgB" | Out-File -FilePath scratch/week9_resources.txt -Append
Write-Output "instanceB=$instanceB" | Out-File -FilePath scratch/week9_resources.txt -Append

Write-Output "peeringId=$peeringId" | Out-File -FilePath scratch/week9_resources.txt -Append

Write-Output "Deployment Complete!"
