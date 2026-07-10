$defaultVpc = aws ec2 describe-vpcs --filters "Name=isDefault,Values=true" --query "Vpcs[0].VpcId" --output text
Write-Output "Default VPC: $defaultVpc"

$subnets = aws ec2 describe-subnets --filters "Name=vpc-id,Values=$defaultVpc" --query "Subnets[*].{SubnetId:SubnetId,AvailabilityZone:AvailabilityZone}" --output json
Write-Output "Subnets:"
Write-Output $subnets
