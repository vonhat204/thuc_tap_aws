# Delete broken VPC-A and VPC-B created earlier
$vpcA = aws ec2 describe-vpcs --filters "Name=tag:Name,Values=VPC-A" --query "Vpcs[0].VpcId" --output text
$vpcB = aws ec2 describe-vpcs --filters "Name=tag:Name,Values=VPC-B" --query "Vpcs[0].VpcId" --output text

if ($vpcA -ne "None") {
    Write-Output "Deleting broken VPC-A: $vpcA"
    aws ec2 delete-vpc --vpc-id $vpcA
}

if ($vpcB -ne "None") {
    Write-Output "Deleting broken VPC-B: $vpcB"
    aws ec2 delete-vpc --vpc-id $vpcB
}
Write-Output "Cleanup done."
