Write-Output "Deploying Lab 27 Resources..."

$vpcId = aws ec2 describe-vpcs --filters "Name=isDefault,Values=true" --query "Vpcs[0].VpcId" --output text
$subnetId = aws ec2 describe-subnets --filters "Name=vpc-id,Values=$vpcId" --query "Subnets[0].SubnetId" --output text
$sgId = aws ec2 describe-security-groups --filters "Name=vpc-id,Values=$vpcId" "Name=group-name,Values=default" --query "SecurityGroups[0].GroupId" --output text
$amiId = aws ssm get-parameters --names /aws/service/ami-amazon-linux-latest/al2023-ami-kernel-6.1-x86_64 --query "Parameters[0].Value" --output text

Write-Output "Launching EC2 instance with Tags..."
$instId = aws ec2 run-instances --image-id $amiId --count 1 --instance-type t2.micro --subnet-id $subnetId --security-group-ids $sgId --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value='FCJ-Web-Server'},{Key=Environment,Value='Production'},{Key=Project,Value='FCJ-Workshop'}]" --query "Instances[0].InstanceId" --output text
Write-Output "EC2 Instance ID: $instId"

Write-Output "Creating Resource Group..."
$query = @"
{
  "ResourceTypeFilters": ["AWS::AllSupported"],
  "TagFilters": [
    {
      "Key": "Environment",
      "Values": ["Production"]
    },
    {
      "Key": "Project",
      "Values": ["FCJ-Workshop"]
    }
  ]
}
"@
Set-Content -Path scratch/rg_query.json -Value $query -Encoding Ascii

aws resource-groups create-group --name FCJ-Production-Group --description "Resource group for FCJ Workshop Production" --resource-query "Type=TAG_FILTERS_1_0,Query=$(Get-Content -Raw scratch/rg_query.json -Encoding Ascii | % {$_ -replace '`r`n',''})" | Out-Null

Write-Output "Lab 27 Resources Created successfully."
