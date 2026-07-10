Write-Output "Waiting for TGW to be deleted..."
while ($true) {
    $tgwStatus = aws ec2 describe-transit-gateways --transit-gateway-ids tgw-09bdbde679e7e449e --query "TransitGateways[0].State" --output text 2>$null
    if ($tgwStatus -eq "deleted" -or [string]::IsNullOrWhiteSpace($tgwStatus) -or $tgwStatus -match "InvalidTransitGatewayID.NotFound") {
        break
    }
    Write-Output "TGW Status: $tgwStatus. Waiting 10s..."
    Start-Sleep -Seconds 10
}

Write-Output "Re-running VPC Cleanup..."
powershell -File scratch/deep_cleanup_vpcs.ps1

Write-Output "Starting Week 10 Deployment..."
powershell -File scratch/deploy_week10.ps1
