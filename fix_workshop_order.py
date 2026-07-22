import os
import re

base_dir = r"d:\thực tập\bai LAB\thuc_tap_aws\content\5-Workshop"

count = 0
for root, dirs, files in os.walk(base_dir):
    for file in files:
        if file.endswith(".md"):
            filepath = os.path.join(root, file)
            with open(filepath, "r", encoding="utf-8") as f:
                content = f.read()
            
            original = content
            
            # Replace weight: 4 with weight: 5 only in the root _index.md / _index.vi.md
            if root == base_dir:
                content = re.sub(r"^weight\s*:\s*4\s*$", "weight: 5", content, flags=re.MULTILINE)
            
            # Replace pre: " <b> 4. with pre: " <b> 5.
            content = re.sub(r'^pre\s*:\s*"\s*<b>\s*4\.', r'pre: " <b> 5.', content, flags=re.MULTILINE)
            
            if content != original:
                with open(filepath, "w", encoding="utf-8") as f:
                    f.write(content)
                count += 1
print(f"Done. Updated {count} files.")
