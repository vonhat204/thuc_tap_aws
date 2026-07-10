Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

function Capture-Screen([string]$path) {
    $screen = [System.Windows.Forms.Screen]::PrimaryScreen
    $bounds = $screen.Bounds
    $bitmap = New-Object System.Drawing.Bitmap $bounds.Width, $bounds.Height
    $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
    $graphics.CopyFromScreen($bounds.Location, [System.Drawing.Point]::Empty, $bounds.Size)
    $bitmap.Save($path, [System.Drawing.Imaging.ImageFormat]::Png)
    $graphics.Dispose()
    $bitmap.Dispose()
    Write-Output "Screenshot saved to $path"
}

# Print CLI info to terminal
Write-Output "=== AWS CLI Profile List ==="
aws configure list

Write-Output "`n=== S3 Buckets & SNS Topics ==="
aws s3 ls | Select-String "vonhat"
aws sns list-topics --query "Topics[?contains(TopicArn, 'Lab11-Topic')]"

Write-Output "`n=== VPC & EC2 Status ==="
aws ec2 describe-vpcs --vpc-ids "vpc-03790b05d94afcb76" --query "Vpcs[0].[VpcId,CidrBlock,State]" --output table
aws ec2 describe-instances --instance-ids "i-0626a0b2b7eea3342" --query "Reservations[0].Instances[0].[InstanceId,State.Name,PublicIpAddress]" --output table

# Capture screenshots
Start-Sleep -Seconds 2
Capture-Screen "d:\thực tập\bai LAB\fcj-workshop-template\static\images\worklog\week5\5.2_cli_profile.png"
Capture-Screen "d:\thực tập\bai LAB\fcj-workshop-template\static\images\worklog\week5\5.3_cli_s3_sns.png"
Capture-Screen "d:\thực tập\bai LAB\fcj-workshop-template\static\images\worklog\week5\5.4_cli_vpc_ec2.png"
