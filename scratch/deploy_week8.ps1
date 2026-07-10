Write-Output "Starting Week 8 Deployments..."

# 1. Fetch Network Info
Write-Output "Fetching Default VPC and Subnets..."
$vpcId = aws ec2 describe-vpcs --filters Name=is-default,Values=true --query "Vpcs[0].VpcId" --output text
$subnet1 = aws ec2 describe-subnets --filters Name=vpc-id,Values=$vpcId Name=availability-zone,Values=ap-southeast-2a --query "Subnets[0].SubnetId" --output text
$subnet2 = aws ec2 describe-subnets --filters Name=vpc-id,Values=$vpcId Name=availability-zone,Values=ap-southeast-2b --query "Subnets[0].SubnetId" --output text

Write-Output "VPC ID: $vpcId"
Write-Output "Subnet A: $subnet1"
Write-Output "Subnet B: $subnet2"

# 2. Create ECS Cluster (with Container Insights)
Write-Output "Creating ECS Cluster..."
aws ecs create-cluster --cluster-name "Lab16Cluster" --settings name=containerInsights,value=enabled

# 3. Create Cloud Map Private DNS Namespace
Write-Output "Creating Cloud Map Private DNS Namespace..."
$nsOpId = aws servicediscovery create-private-dns-namespace --name "vonhat.local" --vpc $vpcId --query "OperationId" --output text
Write-Output "Cloud Map Operation ID: $nsOpId"

# 4. Register ECS Task Definition
Write-Output "Registering ECS Task Definition..."
aws ecs register-task-definition --cli-input-json file://scratch/ecs-task-def.json

# 5. Create Security Group for ALB and ECS
Write-Output "Creating Security Group for ALB and ECS..."
$sgId = aws ec2 create-security-group --group-name "Lab16-SG" --description "ECS & ALB Security Group" --vpc-id $vpcId --query "GroupId" --output text
aws ec2 authorize-security-group-ingress --group-id $sgId --protocol tcp --port 80 --cidr 0.0.0.0/0
Write-Output "Security Group ID: $sgId"

# 6. Create Application Load Balancer
Write-Output "Creating ALB..."
$albArn = aws elbv2 create-load-balancer --name "Lab16-ALB" --subnets $subnet1 $subnet2 --security-groups $sgId --query "LoadBalancers[0].LoadBalancerArn" --output text
Write-Output "ALB ARN: $albArn"

# 7. Create Target Group
Write-Output "Creating Target Group..."
$tgArn = aws elbv2 create-target-group --name "Lab16-TG" --protocol HTTP --port 80 --vpc-id $vpcId --target-type ip --query "TargetGroups[0].TargetGroupArn" --output text
Write-Output "Target Group ARN: $tgArn"

# 8. Create Listener for ALB
Write-Output "Creating Listener for ALB..."
$listenerArn = aws elbv2 create-listener --load-balancer-arn $albArn --protocol HTTP --port 80 --default-actions Type=forward,TargetGroupArn=$tgArn --query "Listeners[0].ListenerArn" --output text
Write-Output "Listener ARN: $listenerArn"

# 9. Create ECS Service
Write-Output "Creating ECS Service..."
aws ecs create-service --cluster "Lab16Cluster" --service-name "web-service" --task-definition "lab16-task" --desired-count 1 --launch-type "FARGATE" --network-configuration "awsvpcConfiguration={subnets=[$subnet1,$subnet2],securityGroups=[$sgId],assignPublicIp=ENABLED}" --load-balancers "targetGroupArn=$tgArn,containerName=web,containerPort=80"

# 10. Create CodeBuild IAM Role and Project
Write-Output "Setting up CodeBuild IAM Role..."
$roleExists = aws iam get-role --role-name CodeBuildServiceRole 2>$null
if (-not $roleExists) {
    aws iam create-role --role-name CodeBuildServiceRole --assume-role-policy-document file://scratch/codebuild-trust-policy.json
    aws iam put-role-policy --role-name CodeBuildServiceRole --policy-name CodeBuildPolicy --policy-document file://scratch/codebuild-role-policy.json
    Write-Output "CodeBuildServiceRole created."
} else {
    Write-Output "CodeBuildServiceRole already exists."
}

Write-Output "Creating CodeBuild Project..."
aws codebuild create-project --name "Lab17CodeBuild" --source "{`"type`": `"NO_SOURCE`"}" --artifacts "{`"type`": `"NO_ARTIFACTS`"}" --environment "{`"type`": `"LINUX_CONTAINER`",`"image`": `"aws/codebuild/standard:5.0`",`"computeType`": `"BUILD_GENERAL1_SMALL`"}" --service-role "arn:aws:iam::316704942380:role/CodeBuildServiceRole"

# Save IDs for cleanup
"vpcId=$vpcId`nsgId=$sgId`nalbArn=$albArn`ntgArn=$tgArn`nlistenerArn=$listenerArn`nnsOpId=$nsOpId" | Set-Content "scratch/week8_resources.txt"

Write-Output "Deployments initiated!"
