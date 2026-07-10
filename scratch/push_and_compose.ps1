Write-Output "Authenticating with ECR..."
$ecrPassword = aws ecr get-login-password --region ap-southeast-2
docker login --username AWS --password $ecrPassword 316704942380.dkr.ecr.ap-southeast-2.amazonaws.com

Write-Output "Pulling Nginx image..."
docker pull nginx:alpine

Write-Output "Tagging and pushing Nginx image to ECR..."
docker tag nginx:alpine 316704942380.dkr.ecr.ap-southeast-2.amazonaws.com/fcj-container-app:latest
docker push 316704942380.dkr.ecr.ap-southeast-2.amazonaws.com/fcj-container-app:latest

Write-Output "Running docker compose locally..."
docker compose -f scratch/docker-compose.yml up -d

Write-Output "Active Docker containers:"
docker ps
