Write-Output "Cleaning up Week 12 Resources..."

Write-Output "Deleting EC2 Instance..."
$vpcId = aws ec2 describe-vpcs --filters "Name=isDefault,Values=true" --query "Vpcs[0].VpcId" --output text
$instances = aws ec2 describe-instances --filters "Name=vpc-id,Values=$vpcId" "Name=tag:Role,Values=StorageGateway" "Name=instance-state-name,Values=running,stopped,pending" --query "Reservations[*].Instances[*].InstanceId" --output text
if ($instances -ne "None" -and -not [string]::IsNullOrWhiteSpace($instances)) {
    aws ec2 terminate-instances --instance-ids ($instances -split '\s+') | Out-Null
}

Write-Output "Deleting S3 Bucket..."
$bucketName = aws s3 ls | grep "fcj-sgw-sync-" | awk '{print $3}'
if (-not [string]::IsNullOrWhiteSpace($bucketName)) {
    aws s3 rm s3://$bucketName --recursive
    aws s3 rb s3://$bucketName
}

Write-Output "Deleting WAF WebACL..."
$wafId = aws wafv2 list-web-acls --scope REGIONAL --query "WebACLs[?Name=='fcj-waf-acl'].Id" --output text
$wafLock = aws wafv2 list-web-acls --scope REGIONAL --query "WebACLs[?Name=='fcj-waf-acl'].LockToken" --output text
if ($wafId -ne "None" -and -not [string]::IsNullOrWhiteSpace($wafId)) {
    aws wafv2 delete-web-acl --name fcj-waf-acl --scope REGIONAL --id $wafId --lock-token $wafLock
}

Write-Output "Deleting WAF IPSet..."
$ipSetId = aws wafv2 list-ip-sets --scope REGIONAL --query "IPSets[?Name=='BlockBadIPs'].Id" --output text
$ipSetLock = aws wafv2 list-ip-sets --scope REGIONAL --query "IPSets[?Name=='BlockBadIPs'].LockToken" --output text
if ($ipSetId -ne "None" -and -not [string]::IsNullOrWhiteSpace($ipSetId)) {
    aws wafv2 delete-ip-set --name BlockBadIPs --scope REGIONAL --id $ipSetId --lock-token $ipSetLock
}

Write-Output "Week 12 Cleanup Complete!"
