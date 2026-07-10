import os
import re

def remove_warnings(directory):
    pattern = re.compile(r"\{\{%\s*notice warning\s*%\}\}[\s\S]*?\{\{%\s*/notice\s*%\}\}\n*", re.MULTILINE)
    count = 0
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith(".md"):
                filepath = os.path.join(root, file)
                with open(filepath, 'r', encoding='utf-8') as f:
                    content = f.read()
                
                new_content, num_subs = re.subn(pattern, '', content)
                if num_subs > 0:
                    with open(filepath, 'w', encoding='utf-8') as f:
                        f.write(new_content)
                    count += num_subs
    
    # Write output to a file to avoid unicode print errors
    with open('remove_result.txt', 'w', encoding='utf-8') as f:
        f.write(f"Total warnings removed: {count}\n")

if __name__ == "__main__":
    content_dir = r"d:\thực tập\bai LAB\fcj-workshop-template\content"
    remove_warnings(content_dir)
