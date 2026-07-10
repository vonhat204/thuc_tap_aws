Add-Type -AssemblyName System.Drawing
$path = "static\images\worklog\week3\3.5_iam_policy.png"
$img = [System.Drawing.Image]::FromFile($path)
$newHeight = 500
$yOffset = ($img.Height - $newHeight) / 2
$rect = New-Object System.Drawing.Rectangle(0, $yOffset, $img.Width, $newHeight)
$bmp = New-Object System.Drawing.Bitmap($rect.Width, $rect.Height)
$graphics = [System.Drawing.Graphics]::FromImage($bmp)
$graphics.DrawImage($img, 0, 0, $rect, [System.Drawing.GraphicsUnit]::Pixel)
$graphics.Dispose()
$img.Dispose()
$bmp.Save("static\images\worklog\week3\3.5_iam_policy_cropped.png", [System.Drawing.Imaging.ImageFormat]::Png)
$bmp.Dispose()
Remove-Item -Path $path -Force
Rename-Item -Path "static\images\worklog\week3\3.5_iam_policy_cropped.png" -NewName "3.5_iam_policy.png"
