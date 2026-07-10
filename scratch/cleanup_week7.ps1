Write-Output "Starting Week 7 resource cleanup..."

# 1. Delete RDS Database
Write-Output "Deleting RDS Database..."
aws rds delete-db-instance --db-instance-identifier "lab15-db" --skip-final-snapshot

# 2. Delete ECR Repository
Write-Output "Deleting ECR Repository..."
aws ecr delete-repository --repository-name "fcj-container-app" --force --region ap-southeast-2

# 3. Delete S3 Bucket
Write-Output "Deleting S3 Bucket..."
aws s3 rb s3://fcj-vmimport-vonhat --force

# 4. Delete IAM Role vmimport
Write-Output "Deleting IAM Role vmimport..."
aws iam delete-role-policy --role-name vmimport --policy-name vmimport
aws iam delete-role --role-name vmimport

# 5. Stop local docker compose
docker compose -f scratch/docker-compose.yml down 2>$null

Write-Output "Cleanup Complete!"
