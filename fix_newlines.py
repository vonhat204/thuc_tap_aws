import os
import re

base_dir = r"d:\thực tập\bai LAB\fcj-workshop-template\content\1-Worklog"
for week in range(1, 13):
    folder_pattern = re.compile(rf"1\.{week}-Week{week}$")
    folder_name = next((f for f in os.listdir(base_dir) if folder_pattern.match(f)), None)
    if not folder_name: continue
    
    for lang in ["vi", "en"]:
        file_name = "_index.vi.md" if lang == "vi" else "_index.md"
        file_path = os.path.join(base_dir, folder_name, file_name)
        if not os.path.exists(file_path): continue
        
        with open(file_path, "r", encoding="utf-8") as f:
            content = f.read()
            
        # The merged string looks like: "... | 04/20/2026 | | 3   |"
        # Or "... | 04/20/2026 | | 3 |"
        # We want to insert a newline before the second pipe sequence.
        # Let's just regex replace `\| (\|\s*\d+\s*\|)` with `|\n\1`
        # Actually it's `| | 3   |` -> `|\n| 3   |`
        # So we can replace `\| \|\s*(\d+\s*)\|` with `|\n| \1|`
        # But wait, it might be `<url> | 3   |`.
        # Let's use regex: `(\|) (\|\s*[2-6]\s*\|)` -> `\1\n\2`
        # Wait, if it's `| | 3   |`, then it is `(\|) (\|\s*[2-6]\s*\|)`. Let's test that.
        
        fixed_content = re.sub(r"(\|\s?)(\|\s*[2-6]\s*\| - )", r"\1\n\2", content)
        
        with open(file_path, "w", encoding="utf-8") as f:
            f.write(fixed_content)
