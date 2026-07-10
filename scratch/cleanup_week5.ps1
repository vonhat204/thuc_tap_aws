Write-Output "Starting Week 5 resource cleanup..."

# 1. Delete EC2
Write-Output "Terminating EC2 Instance..."
aws ec2 terminate-instances --instance-ids "i-0626a0b2b7eea3342"
Write-Output "Waiting for instance to terminate..."
aws ec2 wait instance-terminated --instance-ids "i-0626a0b2b7eea3342"

# 2. Delete S3 Bucket
Write-Output "Deleting S3 Bucket..."
aws s3 rb s3://fcj-lab11-bucket-vonhat --force

# 3. Delete SNS Topic
Write-Output "Deleting SNS Topic..."
aws sns delete-topic --topic-arn "arn:aws:sns:ap-southeast-2:316704942380:Lab11-Topic"

# 4. Delete VPC Network Resources
Write-Output "Deleting Security Group..."
aws ec2 delete-security-group --group-id "sg-0aa47ca0db97ac13b"

Write-Output "Detaching Internet Gateway..."
aws ec2 detach-internet-gateway --internet-gateway-id "igw-0ae3ab582cd30d337" --vpc-id "vpc-03790b05d94afcb76"
aws ec2 delete-internet-gateway --internet-gateway-id "igw-0ae3ab582cd30d337"

Write-Output "Deleting Subnet..."
aws ec2 delete-subnet --subnet-id "subnet-061107fcca034b43f"

Write-Output "Deleting Route Table..."
aws ec2 delete-route-table --route-table-id "rtb-08b88b9b0453a1686"

Write-Output "Deleting VPC..."
aws ec2 delete-vpc --vpc-id "vpc-03790b05d94afcb76"

# 5. Delete AWS Organizations SCP & OU
Write-Output "Detaching SCP from OU..."
aws organizations detach-policy --policy-id "p-auuornpk" --target-id "ou-qjb1-yxkchg9m"

Write-Output "Deleting SCP Policy..."
aws organizations delete-policy --policy-id "p-auuornpk"

Write-Output "Deleting OU..."
aws organizations delete-organizational-unit --organizational-unit-id "ou-qjb1-yxkchg9m"

Write-Output "Cleanup Complete!"
