import os
import re
from datetime import datetime, timedelta

weeks = {
    1: '2026-04-20',
    2: '2026-04-27',
    3: '2026-05-04',
    4: '2026-05-11',
    5: '2026-05-18',
    6: '2026-05-25',
    7: '2026-06-01',
    8: '2026-06-08',
    9: '2026-06-15',
    10: '2026-06-22',
    11: '2026-06-29',
    12: '2026-07-06',
}

base_dir = r"d:\thực tập\bai LAB\fcj-workshop-template\content\1-Worklog"

for week_num, start_str in weeks.items():
    start = datetime.strptime(start_str, '%Y-%m-%d')
    
    folder_pattern = re.compile(rf"1\.{week_num}-Week{week_num}$")
    folder_path = None
    for item in os.listdir(base_dir):
        if folder_pattern.match(item):
            folder_path = os.path.join(base_dir, item)
            break
    if not folder_path:
        continue
    
    file_path = os.path.join(folder_path, '_index.vi.md')
    if not os.path.exists(file_path):
        continue
        
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
        
    lines = content.split('\n')
    in_table = False
    
    new_lines = lines[:]
    for i, line in enumerate(new_lines):
        if line.strip().startswith('|'):
            if 'Thứ' in line or '---' in line:
                continue
            parts = line.split('|')
            if len(parts) >= 6:
                # parts[1] should be the day (2, 3, 4, 5, 6)
                day_str = parts[1].strip()
                if day_str.isdigit():
                    day_offset = int(day_str) - 2
                    date_val = start + timedelta(days=day_offset)
                    date_str = date_val.strftime('%d/%m/%Y')
                    parts[3] = f" {date_str} "
                    parts[4] = f" {date_str} "
                    new_lines[i] = '|'.join(parts)
            
    with open(file_path, 'w', encoding='utf-8') as f:
        f.write('\n'.join(new_lines))
        
    print(f"Fixed Week {week_num} table")
