Write-Output "Starting cleanup of Week 4 resources..."

# 1. Delete ASG
Write-Output "Deleting Auto Scaling Group..."
aws autoscaling delete-auto-scaling-group --auto-scaling-group-name "Lab6-ASG" --force-delete

# 2. Delete ALB
Write-Output "Deleting Load Balancer..."
aws elbv2 delete-load-balancer --load-balancer-arn "arn:aws:elasticloadbalancing:ap-southeast-2:316704942380:loadbalancer/app/Lab6-ALB/3029af6e2b133159"

# Wait a bit
Start-Sleep -Seconds 15

# 3. Delete Target Group
Write-Output "Deleting Target Group..."
aws elbv2 delete-target-group --target-group-arn "arn:aws:elasticloadbalancing:ap-southeast-2:316704942380:targetgroup/Lab6-TG/883443865365cb5e"

# 4. Delete Launch Template
Write-Output "Deleting Launch Template..."
aws ec2 delete-launch-template --launch-template-name "Lab6-LaunchTemplate"

# 5. Delete Budget
Write-Output "Deleting Budget..."
$accountId = aws sts get-caller-identity --query "Account" --output text
aws budgets delete-budget --account-id $accountId --budget-name "Lab7-Cost-Budget"

# 6. Delete CloudWatch Alarm
Write-Output "Deleting Alarm..."
aws cloudwatch delete-alarms --alarm-names "ASG-High-CPU-Alarm"

# 7. Delete CloudWatch Dashboard
Write-Output "Deleting Dashboard..."
aws cloudwatch delete-dashboards --dashboard-names "Lab8-Dashboard"

# 8. Delete Log Group
Write-Output "Deleting Log Group..."
aws logs delete-log-group --log-group-name "Lab8-LogGroup"

Write-Output "Cleanup complete!"
