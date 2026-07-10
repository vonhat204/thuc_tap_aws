import os
import re

base_dir = r"d:\thực tập\bai LAB\fcj-workshop-template\content\1-Worklog"
for week in range(1, 13):
    folder_pattern = re.compile(rf"1\.{week}-Week{week}$")
    folder_path = None
    for item in os.listdir(base_dir):
        if folder_pattern.match(item):
            folder_path = os.path.join(base_dir, item)
            break
    if not folder_path: continue
    
    file_path = os.path.join(folder_path, '_index.vi.md')
    if not os.path.exists(file_path): continue
        
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    print(f"--- Week {week} ---")
    in_table = False
    for line in content.split('\n'):
        if line.strip().startswith('|'):
            if 'Thứ' in line or '---' in line:
                continue
            parts = line.split('|')
            if len(parts) > 1:
                print(parts[1].strip())
