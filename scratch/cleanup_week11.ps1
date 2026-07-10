Write-Output "Starting Week 11 Cleanup..."

# 1. Delete CodePipeline
Write-Output "Deleting CodePipeline..."
aws codepipeline delete-pipeline --name fcj-webapp-pipeline

# 2. Terminate EC2 Instance
Write-Output "Terminating EC2 Instance..."
$vpcId = aws ec2 describe-vpcs --filters "Name=isDefault,Values=true" --query "Vpcs[0].VpcId" --output text
if ($vpcId -ne "None" -and -not [string]::IsNullOrWhiteSpace($vpcId)) {
    $instances = aws ec2 describe-instances --filters "Name=vpc-id,Values=$vpcId" "Name=tag:Name,Values=CodeDeployServer" "Name=instance-state-name,Values=running,stopped,pending" --query "Reservations[*].Instances[*].InstanceId" --output text
    if ($instances -ne "None" -and -not [string]::IsNullOrWhiteSpace($instances)) {
        aws ec2 terminate-instances --instance-ids ($instances -split '\s+') | Out-Null
    }
}

# 3. Empty S3 Bucket
Write-Output "Emptying S3 Artifact Bucket..."
$bucketName = aws cloudformation describe-stacks --stack-name fcj-week11 --query "Stacks[0].Outputs[?OutputKey=='BucketName'].OutputValue" --output text
if ($bucketName -ne "None" -and -not [string]::IsNullOrWhiteSpace($bucketName)) {
    aws s3 rm s3://$bucketName --recursive
}

# 4. Delete CloudFormation Stack
Write-Output "Deleting CloudFormation Stack (this will delete CodeBuild, CodeDeploy, CodeCommit, and IAM Roles)..."
aws cloudformation delete-stack --stack-name fcj-week11
aws cloudformation wait stack-delete-complete --stack-name fcj-week11

Write-Output "Week 11 Cleanup Complete!"
