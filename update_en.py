import os
import re
from datetime import datetime, timedelta

base_dir = r"d:\thực tập\bai LAB\fcj-workshop-template\content\1-Worklog"

# Week start dates (Mondays)
week_starts = {
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
    12: '2026-07-06'
}

for week in range(1, 13):
    folder_pattern = re.compile(rf"1\.{week}-Week{week}$")
    folder_name = next((f for f in os.listdir(base_dir) if folder_pattern.match(f)), None)
    if not folder_name: continue
    
    start_date_str = week_starts[week]
    start_date = datetime.strptime(start_date_str, "%Y-%m-%d")
    
    for lang in ["vi", "en"]:
        file_name = "_index.vi.md" if lang == "vi" else "_index.md"
        file_path = os.path.join(base_dir, folder_name, file_name)
        if not os.path.exists(file_path): continue
        
        with open(file_path, "r", encoding="utf-8") as f:
            lines = f.readlines()
            
        new_lines = []
        for line in lines:
            if re.match(r"^\s*\|\s*\d+\s*\|", line):
                parts = line.split("|")
                if len(parts) >= 6:
                    day_str = parts[1].strip()
                    try:
                        day_num = int(day_str)
                        if 2 <= day_num <= 6:
                            target_date = start_date + timedelta(days=day_num - 2)
                            if lang == "vi":
                                date_formatted = target_date.strftime("%d/%m/%Y")
                            else:
                                date_formatted = target_date.strftime("%m/%d/%Y")
                            parts[3] = f" {date_formatted} "
                            parts[4] = f" {date_formatted} "
                    except ValueError:
                        pass
                    
                    # Sources
                    task_col = parts[2]
                    lab_match = re.search(r"Lab (\d+)", task_col, re.IGNORECASE)
                    
                    if lab_match:
                        lab_num = lab_match.group(1)
                        padded = lab_num.zfill(6)
                        parts[5] = f" <https://{padded}.awsstudygroup.com/> "
                    elif week == 1 and day_num >= 3:
                        # For week 1, day 3,4,5,6 assign to lab 1
                        parts[5] = f" <https://000001.awsstudygroup.com/> "
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
