# Terminate old Windows instance
$oldInstance = "i-0ba9363b5773e83ee"
Write-Output "Terminating old Windows instance..."
aws ec2 terminate-instances --instance-ids $oldInstance

# Create new UserData with Firewall rule
$winUserData = @"
<powershell>
New-NetFirewallRule -DisplayName "Allow HTTP" -Direction Inbound -LocalPort 80 -Protocol TCP -Action Allow
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

# Launch new instance
$vpcId = "vpc-08f49243da9f25c83"
$subnetId = "subnet-04d5407432a6560a0"
$winSgId = "sg-002667e363708a28c"
$winAmi = "ami-01ff74c1c967a8dd4"

Write-Output "Launching new Windows instance..."
$winInstance = aws ec2 run-instances --image-id $winAmi --instance-type t3.micro --security-group-ids $winSgId --subnet-id $subnetId --associate-public-ip-address --user-data file://scratch/win_userdata.txt --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=Windows-Server}]" --query "Instances[0].InstanceId" --output text
Write-Output "New Windows Instance: $winInstance"

Start-Sleep -Seconds 10
$winIp = aws ec2 describe-instances --instance-ids $winInstance --query "Reservations[0].Instances[0].PublicIpAddress" --output text
Write-Output "New Windows IP: $winIp"

# Update resources file
$content = Get-Content "scratch/week3_resources.txt"
$newContent = $content -replace "winInstance=i-0ba9363b5773e83ee", "winInstance=$winInstance"
$newContent = $newContent -replace "winIp=3.107.196.90", "winIp=$winIp"
$newContent | Set-Content "scratch/week3_resources.txt"
