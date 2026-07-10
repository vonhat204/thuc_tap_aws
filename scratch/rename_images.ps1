$dir = "d:\thực tập\bai LAB\fcj-workshop-template\static\images\worklog\week12"

Remove-Item "$dir\12.4_fsx_system.png" -ErrorAction SilentlyContinue
Remove-Item "$dir\12.5_fsx_mount.png" -ErrorAction SilentlyContinue
Remove-Item "$dir\12.6_fsx_shadow_copies.png" -ErrorAction SilentlyContinue

Rename-Item "$dir\12.7_waf_acl.png" "12.4_waf_acl.png"
Rename-Item "$dir\12.8_waf_rules.png" "12.5_waf_rules.png"
Rename-Item "$dir\12.9_waf_blocked.png" "12.6_waf_blocked.png"
