Add-Type -AssemblyName System.Drawing
$path = "static\images\worklog\week1\1.2_ec2_console.png"
$img = [System.Drawing.Image]::FromFile($path)
$newHeight = 350
$rect = New-Object System.Drawing.Rectangle(0, 0, $img.Width, $newHeight)
$bmp = New-Object System.Drawing.Bitmap($rect.Width, $rect.Height)
$graphics = [System.Drawing.Graphics]::FromImage($bmp)
$graphics.DrawImage($img, 0, 0, $rect, [System.Drawing.GraphicsUnit]::Pixel)
$graphics.Dispose()
$img.Dispose()
$bmp.Save("static\images\worklog\week1\1.2_ec2_console_cropped.png", [System.Drawing.Imaging.ImageFormat]::Png)
$bmp.Dispose()
Remove-Item -Path $path -Force
Rename-Item -Path "static\images\worklog\week1\1.2_ec2_console_cropped.png" -NewName "1.2_ec2_console.png"

$path2 = "static\images\worklog\week1\1.3_ebs_attached.png"
$img2 = [System.Drawing.Image]::FromFile($path2)
$newHeight2 = 450
$rect2 = New-Object System.Drawing.Rectangle(0, 0, $img2.Width, $newHeight2)
$bmp2 = New-Object System.Drawing.Bitmap($rect2.Width, $rect2.Height)
$graphics2 = [System.Drawing.Graphics]::FromImage($bmp2)
$graphics2.DrawImage($img2, 0, 0, $rect2, [System.Drawing.GraphicsUnit]::Pixel)
$graphics2.Dispose()
$img2.Dispose()
$bmp2.Save("static\images\worklog\week1\1.3_ebs_attached_cropped.png", [System.Drawing.Imaging.ImageFormat]::Png)
$bmp2.Dispose()
Remove-Item -Path $path2 -Force
Rename-Item -Path "static\images\worklog\week1\1.3_ebs_attached_cropped.png" -NewName "1.3_ebs_attached.png"
