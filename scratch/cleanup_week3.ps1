Write-Output "Starting cleanup of Week 3 resources..."

# 1. Delete RDS DB Instance
Write-Output "Deleting RDS Database (skip final snapshot)..."
aws rds delete-db-instance --db-instance-identifier "lab5-rds" --skip-final-snapshot

# 2. Terminate EC2 instances
Write-Output "Terminating EC2 instances..."
aws ec2 terminate-instances --instance-ids i-0aa49211d0f226b2b i-0208a5b34c7e37408

# 3. Deregister AMI
Write-Output "Deregistering Custom AMI..."
aws ec2 deregister-image --image-id ami-02bb730a4baa58abe

# 4. Delete Snapshot
Write-Output "Deleting Snapshot..."
aws ec2 delete-snapshot --snapshot-id snap-05096baea641ad758

Write-Output "Primary resource deletion initiated."
