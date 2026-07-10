$linuxInstance = "i-0208a5b34c7e37408"
# Get volume ID
$volumeId = aws ec2 describe-instances --instance-ids $linuxInstance --query "Reservations[0].Instances[0].BlockDeviceMappings[0].Ebs.VolumeId" --output text
Write-Output "Volume ID: $volumeId"

# Create Snapshot
$snapshotId = aws ec2 create-snapshot --volume-id $volumeId --description "Backup for Linux Server" --query "SnapshotId" --output text
Write-Output "Snapshot ID: $snapshotId"

# Create AMI
$amiId = aws ec2 create-image --instance-id $linuxInstance --name "MyLinuxImage-Week3" --description "Custom Linux AMI" --no-reboot --query "ImageId" --output text
Write-Output "AMI ID: $amiId"

"linuxVolumeId=$volumeId`nlinuxSnapshotId=$snapshotId`nlinuxAmiId=$amiId" | Add-Content "scratch/week3_resources.txt"
