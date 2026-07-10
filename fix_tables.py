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
            
        # Remove empty lines between table rows (lines starting with |)
        # We can just read line by line and if it's an empty line, 
        # and the previous non-empty line was a table row, and the next is a table row...
        # Actually it's easier:
        lines = content.split('\n')
        new_lines = []
        for i, line in enumerate(lines):
            if line.strip() == "":
                # Check if previous line starts with | and next line starts with |
                # wait, since there might be multiple empty lines, just check surroundings
                prev_line = lines[i-1].strip() if i > 0 else ""
                next_line = lines[i+1].strip() if i < len(lines)-1 else ""
                if prev_line.startswith("|") and next_line.startswith("|"):
                    continue # skip this empty line
            new_lines.append(line)
            
        # Wait, what if the `\n` was placed such that `| 2 | ... | \n | 3 |` ?
        # My previous script did `re.sub(r"(\|\s?)(\|\s*[2-6]\s*\| - )", r"\1\n\2", content)`
        # If it was `| 2 | ... | | 3 |`, it became `| 2 | ... |\n| 3 |`. This shouldn't produce empty lines!
        # Ah! `|\n\n|` maybe? Because the original had `\n`?
        
        # Just write new_lines
        with open(file_path, "w", encoding="utf-8") as f:
            f.write("\n".join(new_lines))
