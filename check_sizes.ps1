Add-Type -AssemblyName System.Drawing
$dir = "static\images\worklog\week3"
foreach ($file in Get-ChildItem -Path $dir -Filter *.png) {
    $img = [System.Drawing.Image]::FromFile($file.FullName)
    Write-Output "$($file.Name): $($img.Width)x$($img.Height)"
    $img.Dispose()
}
