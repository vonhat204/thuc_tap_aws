Write-Output "Starting Week 7 Deployments..."

$bucketName = "fcj-vmimport-vonhat"
$repoName = "fcj-container-app"
$dbName = "lab15-db"

# 1. Create S3 bucket for VM Import
Write-Output "Creating S3 bucket for VM Import..."
aws s3 mb s3://$bucketName --region ap-southeast-2

# Upload dummy VMDK file
Write-Output "Uploading dummy VMDK disk..."
New-Item -Path "scratch/disk.vmdk" -ItemType File -Value "dummy VM disk data" -Force
aws s3 cp scratch/disk.vmdk s3://$bucketName/disk.vmdk

# 2. Create IAM Role vmimport
Write-Output "Checking and creating IAM Role vmimport..."
$roleExists = aws iam get-role --role-name vmimport 2>$null
if (-not $roleExists) {
    aws iam create-role --role-name vmimport --assume-role-policy-document file://scratch/trust-policy.json
    aws iam put-role-policy --role-name vmimport --policy-name vmimport --policy-document file://scratch/role-policy.json
    Write-Output "IAM Role vmimport created."
} else {
    Write-Output "IAM Role vmimport already exists."
}

# 3. Create ECR Repository
Write-Output "Creating ECR Repository..."
aws ecr create-repository --repository-name $repoName --region ap-southeast-2

# 4. Authenticate Docker with ECR & Push Image
Write-Output "Authenticating Docker with ECR..."
$ecrPassword = aws ecr get-login-password --region ap-southeast-2
docker login --username AWS --password $ecrPassword 316704942380.dkr.ecr.ap-southeast-2.amazonaws.com

Write-Output "Pulling Nginx image..."
docker pull nginx:alpine

Write-Output "Tagging and pushing Nginx image to ECR..."
docker tag nginx:alpine 316704942380.dkr.ecr.ap-southeast-2.amazonaws.com/fcj-container-app:latest
docker push 316704942380.dkr.ecr.ap-southeast-2.amazonaws.com/fcj-container-app:latest

# 5. Create RDS MySQL Instance
Write-Output "Creating RDS MySQL instance..."
aws rds create-db-instance --db-instance-identifier $dbName --db-instance-class "db.t3.micro" --engine "mysql" --allocated-storage 20 --master-username "admin" --master-user-password "Vonnhat123@123" --backup-retention-period 0 --publicly-accessible

# 6. Run Docker Compose locally
Write-Output "Running docker-compose locally..."
docker compose -f scratch/docker-compose.yml up -d

Write-Output "Deployments Completed Successfully!"
"bucketName=$bucketName`nrepoName=$repoName`ndbName=$dbName" | Set-Content "scratch/week7_resources.txt"
