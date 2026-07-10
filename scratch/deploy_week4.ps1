Write-Output "Starting Week 4 Deployments..."

$vpcId = "vpc-08f49243da9f25c83"
$subnet1 = "subnet-0676c3f84852870d4"
$subnet2 = "subnet-04d5407432a6560a0"
$sgId = "sg-0992ab9575f2d182b"

# 1. Create Target Group
Write-Output "Creating Target Group..."
$tgArn = aws elbv2 create-target-group --name "Lab6-TG" --protocol HTTP --port 80 --vpc-id $vpcId --target-type instance --query "TargetGroups[0].TargetGroupArn" --output text
Write-Output "Target Group ARN: $tgArn"

# 2. Create Launch Template
Write-Output "Creating Launch Template..."
aws ec2 create-launch-template --launch-template-name "Lab6-LaunchTemplate" --launch-template-data file://scratch/lt-data.json

# 3. Create Application Load Balancer
Write-Output "Creating Application Load Balancer..."
$albArn = aws elbv2 create-load-balancer --name "Lab6-ALB" --subnets $subnet1 $subnet2 --security-groups $sgId --query "LoadBalancers[0].LoadBalancerArn" --output text
$albDns = aws elbv2 describe-load-balancers --load-balancer-arns $albArn --query "LoadBalancers[0].DNSName" --output text
Write-Output "ALB ARN: $albArn"
Write-Output "ALB DNS: $albDns"

# 4. Create ALB Listener
Write-Output "Creating ALB Listener..."
aws elbv2 create-listener --load-balancer-arn $albArn --protocol HTTP --port 80 --default-actions Type=forward,TargetGroupArn=$tgArn

# 5. Create Auto Scaling Group
Write-Output "Creating Auto Scaling Group..."
aws autoscaling create-auto-scaling-group --auto-scaling-group-name "Lab6-ASG" --launch-template LaunchTemplateName=Lab6-LaunchTemplate --min-size 1 --max-size 3 --desired-capacity 2 --vpc-zone-identifier "$subnet1,$subnet2" --target-group-arns $tgArn

# 6. Create AWS Budget
Write-Output "Creating AWS Budget..."
$accountId = aws sts get-caller-identity --query "Account" --output text
aws budgets create-budget --account-id $accountId --budget file://scratch/budget.json --notifications-with-subscribers file://scratch/notifications.json

Write-Output "Deployment Complete! Save resources for cleanup later."
"tgArn=$tgArn`nalbArn=$albArn`nalbDns=$albDns`naccountId=$accountId" | Set-Content "scratch/week4_resources.txt"
