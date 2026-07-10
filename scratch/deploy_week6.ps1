Write-Output "Starting Week 6 Deployments..."

# 1. Create VPC and Subnets
Write-Output "Creating VPC..."
$vpcId = aws ec2 create-vpc --cidr-block 10.20.0.0/16 --query "Vpc.VpcId" --output text
aws ec2 create-tags --resources $vpcId --tags Key=Name,Value=Lab10-VPC

$subnet1 = aws ec2 create-subnet --vpc-id $vpcId --cidr-block 10.20.1.0/24 --availability-zone ap-southeast-2a --query "Subnet.SubnetId" --output text
aws ec2 create-tags --resources $subnet1 --tags Key=Name,Value=Lab10-Subnet-A

$subnet2 = aws ec2 create-subnet --vpc-id $vpcId --cidr-block 10.20.2.0/24 --availability-zone ap-southeast-2b --query "Subnet.SubnetId" --output text
aws ec2 create-tags --resources $subnet2 --tags Key=Name,Value=Lab10-Subnet-B

Write-Output "VPC ID: $vpcId"
Write-Output "Subnet A: $subnet1"
Write-Output "Subnet B: $subnet2"

# 2. Create Active Directory (Simple AD)
Write-Output "Creating Simple AD..."
$directoryId = aws ds create-simple-ad --name "corp.vonhat.com" --password "Vonnhat123@123" --size "Small" --vpc-settings VpcId=$vpcId,SubnetIds=$subnet1,$subnet2 --query "DirectoryId" --output text
Write-Output "Directory ID: $directoryId"

# 3. Create Security Group for Route 53 resolver
Write-Output "Creating Security Group for Route 53 Resolver..."
$sgId = aws ec2 create-security-group --group-name "Resolver-SG" --description "Route 53 Resolver Security Group" --vpc-id $vpcId --query "GroupId" --output text
aws ec2 authorize-security-group-ingress --group-id $sgId --protocol tcp --port 53 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id $sgId --protocol udp --port 53 --cidr 0.0.0.0/0
Write-Output "Security Group ID: $sgId"

# 4. Create Inbound Resolver Endpoint
Write-Output "Creating Route 53 Inbound Resolver Endpoint..."
$inEndpointId = aws route53resolver create-resolver-endpoint --name "InboundEndpoint" --direction INBOUND --ip-addresses SubnetId=$subnet1 SubnetId=$subnet2 --security-group-ids $sgId --query "ResolverEndpoint.Id" --output text
Write-Output "Inbound Endpoint ID: $inEndpointId"

# 5. S3 Bucket
Write-Output "Creating S3 Backup Bucket..."
aws s3 mb s3://fcj-lab13-backup-vonhat --region ap-southeast-2

# 6. AWS Backup Vault & Plan
Write-Output "Creating AWS Backup Vault..."
aws backup create-backup-vault --backup-vault-name "Lab13Vault"

Write-Output "Creating AWS Backup Plan..."
$planId = aws backup create-backup-plan --backup-plan file://scratch/backup-plan.json --query "BackupPlanId" --output text
Write-Output "Backup Plan ID: $planId"

# Save resource IDs
"vpcId=$vpcId`nsubnet1=$subnet1`nsubnet2=$subnet2`ndirectoryId=$directoryId`nsgId=$sgId`ninEndpointId=$inEndpointId`nplanId=$planId" | Set-Content "scratch/week6_resources.txt"

Write-Output "Deployments initiated!"
