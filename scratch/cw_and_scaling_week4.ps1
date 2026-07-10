Write-Output "Configuring Scaling Policy and CloudWatch Dashboard..."

# 1. Put Scaling Policy
aws autoscaling put-scaling-policy --auto-scaling-group-name "Lab6-ASG" --policy-name "CPU-Target-Tracking" --policy-type TargetTrackingScaling --target-tracking-configuration file://scratch/asg-config.json

# 2. Put CloudWatch Dashboard
aws cloudwatch put-dashboard --dashboard-name "Lab8-Dashboard" --dashboard-body file://scratch/dashboard.json

# 3. Create CloudWatch Alarm for high CPU
aws cloudwatch put-metric-alarm --alarm-name "ASG-High-CPU-Alarm" --alarm-description "Alarm when ASG average CPU exceeds 80%" --metric-name CPUUtilization --namespace AWS/EC2 --statistic Average --period 300 --threshold 80 --comparison-operator GreaterThanOrEqualToThreshold --evaluation-periods 1 --dimensions Name=AutoScalingGroupName,Value=Lab6-ASG

Write-Output "Configuration Complete!"
