Write-Output "Starting Week 6 resource cleanup..."

# 1. Delete Directory Service AD
Write-Output "Deleting Directory Service AD..."
aws ds delete-directory --directory-id "d-97679a5066"

# 2. Delete Route 53 Resolver Endpoint
Write-Output "Deleting Route 53 Resolver Endpoint..."
aws route53resolver delete-resolver-endpoint --resolver-endpoint-id "rslvr-in-e4fcd41cc3594349a"

# 3. Delete Backup Plan
Write-Output "Deleting Backup Plan..."
aws backup delete-backup-plan --backup-plan-id "1487f322-ac12-445c-b81e-3ffb64a9fda1"

# 4. Delete Backup Vault
Write-Output "Deleting Backup Vault..."
aws backup delete-backup-vault --backup-vault-name "Lab13Vault"

# 5. Delete S3 Bucket
Write-Output "Deleting S3 Bucket..."
aws s3 rb s3://fcj-lab13-backup-vonhat --force

Write-Output "Triggered resource deletions. AD and Endpoints are deleting in background."
