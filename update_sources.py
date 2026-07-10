import os
import re

base_dir = r"d:\thực tập\bai LAB\fcj-workshop-template\content\1-Worklog"
for week in range(1, 12): # 1 to 11
    folder_pattern = re.compile(rf"1\.{week}-Week{week}$")
    folder_name = next((f for f in os.listdir(base_dir) if folder_pattern.match(f)), None)
    if not folder_name: continue
    
    file_path = os.path.join(base_dir, folder_name, "_index.vi.md")
    if not os.path.exists(file_path): continue
    
    with open(file_path, "r", encoding="utf-8") as f:
        lines = f.readlines()
        
    new_lines = []
    for line in lines:
        if re.match(r"^\s*\|\s*\d+\s*\|", line):
            parts = line.split("|")
            if len(parts) >= 7:
                task_col = parts[2]
                lab_match = re.search(r"Lab (\d+)", task_col, re.IGNORECASE)
                if lab_match:
                    lab_num = lab_match.group(1)
                    padded = lab_num.zfill(6)
                    parts[5] = f" <https://{padded}.awsstudygroup.com/> "
                else:
                    parts[5] = " "
                
                new_line = "|".join(parts)
                new_lines.append(new_line)
            else:
                new_lines.append(line)
        else:
            new_lines.append(line)
            
    with open(file_path, "w", encoding="utf-8") as f:
        f.writelines(new_lines)
