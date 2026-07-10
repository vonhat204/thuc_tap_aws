import os
import re
from datetime import datetime, timedelta

weeks = {
    1: ('2026-04-20', '2026-04-28'),
    2: ('2026-04-27', '2026-05-03'),
    3: ('2026-05-04', '2026-05-10'),
    4: ('2026-05-11', '2026-05-17'),
    5: ('2026-05-18', '2026-05-24'),
    6: ('2026-05-25', '2026-05-31'),
    7: ('2026-06-01', '2026-06-07'),
    8: ('2026-06-08', '2026-06-14'),
    9: ('2026-06-15', '2026-06-21'),
    10: ('2026-06-22', '2026-06-28'),
    11: ('2026-06-29', '2026-07-05'),
    12: ('2026-07-06', '2026-07-10'),
}

def generate_dates(start_str, end_str, num_items):
    start = datetime.strptime(start_str, '%Y-%m-%d')
    end = datetime.strptime(end_str, '%Y-%m-%d')
    if num_items == 1:
        return [start]
    delta = (end - start).days
    step = delta / (num_items - 1)
    dates = [start + timedelta(days=round(i * step)) for i in range(num_items)]
    return dates

base_dir = r"d:\thực tập\bai LAB\fcj-workshop-template\content\1-Worklog"

for week_num, (start_str, end_str) in weeks.items():
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
        
    # Find table
    # We look for lines starting with |
    lines = content.split('\n')
    in_table = False
    table_start_idx = -1
    table_end_idx = -1
    for i, line in enumerate(lines):
        if line.strip().startswith('|'):
            if not in_table:
                in_table = True
                table_start_idx = i
            table_end_idx = i
        else:
            if in_table:
                break
                
    if table_start_idx == -1:
        continue
        
    header_idx = table_start_idx
    sep_idx = table_start_idx + 1
    data_indices = range(table_start_idx + 2, table_end_idx + 1)
    
    num_tasks = len(data_indices)
    if num_tasks == 0:
        continue
        
    dates = generate_dates(start_str, end_str, num_tasks)
    
    new_lines = lines[:]
    for i, data_idx in enumerate(data_indices):
        line = new_lines[data_idx]
        parts = line.split('|')
        if len(parts) >= 6:
            # parts[0] is empty (before first |)
            # parts[1] is Thứ
            # parts[2] is Công việc
            # parts[3] is Ngày bắt đầu
            # parts[4] is Ngày hoàn thành
            # parts[5] is Nguồn tài liệu
            date_str = dates[i].strftime('%d/%m/%Y')
            parts[3] = f" {date_str} "
            parts[4] = f" {date_str} "
            new_lines[data_idx] = '|'.join(parts)
            
    with open(file_path, 'w', encoding='utf-8') as f:
        f.write('\n'.join(new_lines))
        
    print(f"Updated Week {week_num} table")
