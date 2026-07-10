Write-Output "Ensuring Default VPC exists..."
$defaultVpc = aws ec2 create-default-vpc --query "Vpc.VpcId" --output text 2>$null
$vpcId = aws ec2 describe-vpcs --filters "Name=isDefault,Values=true" --query "Vpcs[0].VpcId" --output text
$subnetId = aws ec2 describe-subnets --filters "Name=vpc-id,Values=$vpcId" --query "Subnets[0].SubnetId" --output text
$sgId = aws ec2 describe-security-groups --filters "Name=vpc-id,Values=$vpcId" "Name=group-name,Values=default" --query "SecurityGroups[0].GroupId" --output text

Write-Output "Launching EC2 for Storage Gateway..."
$amiId = aws ssm get-parameters --names /aws/service/ami-amazon-linux-latest/al2023-ami-kernel-6.1-x86_64 --query "Parameters[0].Value" --output text
$instId = aws ec2 run-instances --image-id $amiId --count 1 --instance-type t2.micro --subnet-id $subnetId --security-group-ids $sgId --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value='File Gateway VM'},{Key=Role,Value=StorageGateway}]" --query "Instances[0].InstanceId" --output text

Write-Output "Creating S3 Bucket for Sync..."
$bucketName = "fcj-sgw-sync-" + (Get-Random -Minimum 1000 -Maximum 9999)
aws s3 mb s3://$bucketName
Set-Content -Path scratch/shared_data.txt -Value "This is some shared data from Storage Gateway"
Set-Content -Path scratch/backup_archive.zip -Value "mock zip content"
aws s3 cp scratch/shared_data.txt s3://$bucketName/
aws s3 cp scratch/backup_archive.zip s3://$bucketName/

Write-Output "Creating WAF IPSet..."
$ipSetArn = aws wafv2 create-ip-set --name "BlockBadIPs" --scope REGIONAL --ip-address-version IPV4 --addresses "192.0.2.0/24" "198.51.100.0/24" --query "Summary.ARN" --output text

Write-Output "Creating WAF WebACL..."
$rules = @"
[
  {
    "Name": "BlockBadIPsRule",
    "Priority": 1,
    "Statement": {
      "IPSetReferenceStatement": {
        "ARN": "$ipSetArn"
      }
    },
    "Action": {
      "Block": {}
    },
    "VisibilityConfig": {
      "SampledRequestsEnabled": true,
      "CloudWatchMetricsEnabled": true,
      "MetricName": "BlockBadIPsRuleMetric"
    }
  },
  {
    "Name": "AWS-AWSManagedRulesCommonRuleSet",
    "Priority": 2,
    "Statement": {
      "ManagedRuleGroupStatement": {
        "VendorName": "AWS",
        "Name": "AWSManagedRulesCommonRuleSet"
      }
    },
    "OverrideAction": {
      "None": {}
    },
    "VisibilityConfig": {
      "SampledRequestsEnabled": true,
      "CloudWatchMetricsEnabled": true,
      "MetricName": "AWSManagedRulesCommonRuleSetMetric"
    }
  }
]
"@
Set-Content -Path scratch/waf_rules.json -Value $rules -Encoding Ascii

aws wafv2 create-web-acl --name fcj-waf-acl --scope REGIONAL --default-action "Allow={}" --visibility-config "SampledRequestsEnabled=true,CloudWatchMetricsEnabled=true,MetricName=fcjWafMetric" --rules file://scratch/waf_rules.json | Out-Null

Write-Output "Week 12 Resources Created!"
Write-Output "BucketName: $bucketName"
