Write-Output "Starting Week 5 Deployments..."

$bucketName = "fcj-lab11-bucket-vonhat"
$topicName = "Lab11-Topic"

# 1. Create S3 Bucket
Write-Output "Creating S3 Bucket..."
aws s3 mb s3://$bucketName --region ap-southeast-2

# 2. Create SNS Topic
Write-Output "Creating SNS Topic..."
$topicArn = aws sns create-topic --name $topicName --query "TopicArn" --output text
Write-Output "SNS Topic ARN: $topicArn"

# 3. Create VPC
Write-Output "Creating VPC..."
$vpcId = aws ec2 create-vpc --cidr-block 10.10.0.0/16 --query "Vpc.VpcId" --output text
aws ec2 create-tags --resources $vpcId --tags Key=Name,Value=Lab11-VPC
Write-Output "VPC ID: $vpcId"

# 4. Create Internet Gateway
Write-Output "Creating Internet Gateway..."
$igwId = aws ec2 create-internet-gateway --query "InternetGateway.InternetGatewayId" --output text
aws ec2 attach-internet-gateway --vpc-id $vpcId --internet-gateway-id $igwId
Write-Output "IGW ID: $igwId"

# 5. Create Subnet
Write-Output "Creating Subnet..."
$subnetId = aws ec2 create-subnet --vpc-id $vpcId --cidr-block 10.10.1.0/24 --query "Subnet.SubnetId" --output text
aws ec2 create-tags --resources $subnetId --tags Key=Name,Value=Lab11-Subnet
Write-Output "Subnet ID: $subnetId"

# 6. Create Route Table and route
Write-Output "Creating Route Table..."
$rtId = aws ec2 create-route-table --vpc-id $vpcId --query "RouteTable.RouteTableId" --output text
aws ec2 create-route --route-table-id $rtId --destination-cidr-block 0.0.0.0/0 --gateway-id $igwId
aws ec2 associate-route-table --subnet-id $subnetId --route-table-id $rtId
Write-Output "Route Table ID: $rtId"

# 7. Create Security Group and authorize ingress
Write-Output "Creating Security Group..."
$sgId = aws ec2 create-security-group --group-name "Lab11-SG" --description "Lab11 Security Group" --vpc-id $vpcId --query "GroupId" --output text
aws ec2 authorize-security-group-ingress --group-id $sgId --protocol tcp --port 22 --cidr 0.0.0.0/0
Write-Output "Security Group ID: $sgId"

# 8. Run EC2 Instance (Amazon Linux 2023)
Write-Output "Launching EC2 instance..."
$instanceId = aws ec2 run-instances --image-id ami-0df585a4f578deee0 --count 1 --instance-type t3.micro --security-group-ids $sgId --subnet-id $subnetId --associate-public-ip-address --query "Instances[0].InstanceId" --output text
Write-Output "EC2 Instance ID: $instanceId"

# 9. Create AWS Organization, OU & SCP
Write-Output "Setting up AWS Organizations..."
# Try to create organization (it might fail if already in one)
$orgInfo = aws organizations create-organization 2>$null
$rootId = aws organizations list-roots --query "Roots[0].Id" --output text
Write-Output "Organizations Root ID: $rootId"

# Create Organizational Unit (OU)
$ouId = aws organizations create-organizational-unit --parent-id $rootId --name "Lab12-OU" --query "OrganizationalUnit.Id" --output text
Write-Output "OU ID: $ouId"

# Create Service Control Policy (SCP)
$policyId = aws organizations create-policy --content file://scratch/scp-policy.json --description "Deny EC2 run" --name "Lab12-Deny-EC2" --type SERVICE_CONTROL_POLICY --query "Policy.PolicySummary.Id" --output text
Write-Output "SCP Policy ID: $policyId"

# Attach SCP to OU
aws organizations attach-policy --policy-id $policyId --target-id $ouId
Write-Output "Attached SCP to OU."

# Save IDs for cleanup
"bucketName=$bucketName`ntopicArn=$topicArn`nvpcId=$vpcId`nigwId=$igwId`nsubnetId=$subnetId`nrtId=$rtId`nsgId=$sgId`ninstanceId=$instanceId`nouId=$ouId`npolicyId=$policyId" | Set-Content "scratch/week5_resources.txt"

Write-Output "Deployments Completed Successfully!"
