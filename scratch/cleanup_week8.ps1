Write-Output "Starting Week 8 resource cleanup..."

# 1. Delete ECS Service (must set desired count to 0 first)
Write-Output "Stopping ECS Service..."
aws ecs update-service --cluster Lab16Cluster --service web-service --desired-count 0
Start-Sleep -Seconds 5
Write-Output "Deleting ECS Service..."
aws ecs delete-service --cluster Lab16Cluster --service web-service --force

# 2. Deregister ECS Task Definition
Write-Output "Deregistering ECS Task Definition..."
aws ecs deregister-task-definition --task-definition lab16-task:1

# 3. Delete ECS Cluster
Write-Output "Deleting ECS Cluster..."
aws ecs delete-cluster --cluster Lab16Cluster

# 4. Delete ALB Listener
Write-Output "Deleting ALB Listener..."
$listenerArn = (Get-Content scratch/week8_resources.txt | Select-String "listenerArn").ToString().Split("=")[1]
aws elbv2 delete-listener --listener-arn $listenerArn

# 5. Delete Load Balancer
Write-Output "Deleting ALB..."
$albArn = (Get-Content scratch/week8_resources.txt | Select-String "albArn").ToString().Split("=")[1]
aws elbv2 delete-load-balancer --load-balancer-arn $albArn
Start-Sleep -Seconds 5

# 6. Delete Target Group
Write-Output "Deleting Target Group..."
$tgArn = (Get-Content scratch/week8_resources.txt | Select-String "tgArn").ToString().Split("=")[1]
aws elbv2 delete-target-group --target-group-arn $tgArn

# 7. Delete Security Group
Write-Output "Deleting Security Group..."
$sgId = (Get-Content scratch/week8_resources.txt | Select-String "sgId").ToString().Split("=")[1]
aws ec2 delete-security-group --group-id $sgId

# 8. Delete Cloud Map Namespace
Write-Output "Deleting Cloud Map Namespace..."
$nsId = aws servicediscovery list-namespaces --query "Namespaces[?Name=='vonhat.local'].Id" --output text
if ($nsId) {
    aws servicediscovery delete-namespace --id $nsId
    Write-Output "Cloud Map Namespace deleted: $nsId"
}

# 9. Delete CodeBuild Project
Write-Output "Deleting CodeBuild Project..."
aws codebuild delete-project --name Lab17CodeBuild

# 10. Delete CodeBuild IAM Role
Write-Output "Deleting CodeBuild IAM Role..."
aws iam delete-role-policy --role-name CodeBuildServiceRole --policy-name CodeBuildPolicy
aws iam delete-role --role-name CodeBuildServiceRole

Write-Output "Week 8 Cleanup Complete!"
