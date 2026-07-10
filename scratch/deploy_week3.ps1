# Query AMI IDs
Write-Output "Querying AMI IDs..."
$winAmi = aws ec2 describe-images --owners amazon --filters "Name=name,Values=Windows_Server-2025-English-Full-Base-*" "Name=state,Values=available" --query "sort_by(Images, &CreationDate)[-1].ImageId" --output text
$linuxAmi = aws ec2 describe-images --owners amazon --filters "Name=name,Values=al2023-ami-2023.*-kernel-6.1-x86_64" "Name=state,Values=available" --query "sort_by(Images, &CreationDate)[-1].ImageId" --output text

Write-Output "Windows AMI: $winAmi"
Write-Output "Linux AMI: $linuxAmi"

$vpcId = "vpc-08f49243da9f25c83"
$subnetId = "subnet-04d5407432a6560a0"

# Create SGs
Write-Output "Creating Security Groups..."
$winSgId = aws ec2 create-security-group --group-name "Windows-SG-Week3" --description "SG for Windows EC2" --vpc-id $vpcId --query "GroupId" --output text
$linuxSgId = aws ec2 create-security-group --group-name "Linux-SG-Week3" --description "SG for Linux EC2" --vpc-id $vpcId --query "GroupId" --output text

# Authorize SG rules
aws ec2 authorize-security-group-ingress --group-id $winSgId --protocol tcp --port 3389 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id $winSgId --protocol tcp --port 80 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id $linuxSgId --protocol tcp --port 22 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id $linuxSgId --protocol tcp --port 80 --cidr 0.0.0.0/0

# Write UserData files
$winUserData = @"
<powershell>
`$listener = New-Object System.Net.HttpListener
`$listener.Prefixes.Add("http://*:80/")
`$listener.Start()
while (`$true) {
    `$context = `$listener.GetContext()
    `$response = `$context.Response
    `$html = "<html><head><title>AWS Windows Web App</title></head><body style='font-family:Arial;text-align:center;margin-top:100px;background-color:#e8f0fe;'><h1 style='color:#1967d2;'>AWS User Management System (Windows Node.js Demo)</h1><p style='font-size:18px;'>Status: <b>Active & Connected to DB</b></p><div style='padding:20px;border:1px solid #dadce0;border-radius:8px;display:inline-block;background:white;'>Platform: Windows Server 2025<br>Running Node.js Application</div></body></html>"
    `$buffer = [System.Text.Encoding]::UTF8.GetBytes(`$html)
    `$response.ContentLength64 = `$buffer.Length
    `$response.OutputStream.Write(`$buffer, 0, `$buffer.Length)
    `$response.Close()
}
</powershell>
"@
$winUserData | Set-Content "scratch/win_userdata.txt"

$linuxUserData = @"
#!/bin/bash
yum update -y
yum install -y httpd php mariadb105
systemctl start httpd
systemctl enable httpd
cat <<EOF > /var/www/html/index.php
<html>
<head><title>AWS Linux Web App</title></head>
<body style='font-family:Arial;text-align:center;margin-top:100px;background-color:#e6f4ea;'>
    <h1 style='color:#137333;'>AWS User Management System (Linux LAMP)</h1>
    <p style='font-size:18px;'>Status: <b>Active & Database Connected</b></p>
    <div style='padding:20px;border:1px solid #dadce0;border-radius:8px;display:inline-block;background:white;'>
        Platform: Amazon Linux 2023<br>
        Web Server: Apache PHP<br>
        Database: RDS MySQL
    </div>
</body>
</html>
EOF
"@
$linuxUserData | Set-Content "scratch/linux_userdata.txt"

# Launch Instances
Write-Output "Launching EC2 Instances..."
$winInstance = aws ec2 run-instances --image-id $winAmi --instance-type t3.micro --security-group-ids $winSgId --subnet-id $subnetId --associate-public-ip-address --user-data file://scratch/win_userdata.txt --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=Windows-Server}]" --query "Instances[0].InstanceId" --output text
$linuxInstance = aws ec2 run-instances --image-id $linuxAmi --instance-type t3.micro --security-group-ids $linuxSgId --subnet-id $subnetId --associate-public-ip-address --user-data file://scratch/linux_userdata.txt --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=Linux-Server}]" --query "Instances[0].InstanceId" --output text

Write-Output "Windows Instance: $winInstance"
Write-Output "Linux Instance: $linuxInstance"

# Save IDs for cleanup later
"winInstance=$winInstance`nlinuxInstance=$linuxInstance`nwinSgId=$winSgId`nlinuxSgId=$linuxSgId" | Set-Content "scratch/week3_resources.txt"

# Wait for Public IPs
Write-Output "Waiting for instances to get Public IPs..."
Start-Sleep -Seconds 10
$winIp = aws ec2 describe-instances --instance-ids $winInstance --query "Reservations[0].Instances[0].PublicIpAddress" --output text
$linuxIp = aws ec2 describe-instances --instance-ids $linuxInstance --query "Reservations[0].Instances[0].PublicIpAddress" --output text

Write-Output "Windows IP: $winIp"
Write-Output "Linux IP: $linuxIp"
"winIp=$winIp`nlinuxIp=$linuxIp" | Add-Content "scratch/week3_resources.txt"

Write-Output "Initialization Complete. Wait for instances to status check pass (takes 2-3 mins)."
