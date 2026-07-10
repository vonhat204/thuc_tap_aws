import os

files = [
    r"d:\thực tập\bai LAB\fcj-workshop-template\content\5-Workshop\5.1-Workshop-overview\_index.vi.md",
    r"d:\thực tập\bai LAB\fcj-workshop-template\content\5-Workshop\5.1-Workshop-overview\_index.md"
]

for filepath in files:
    if os.path.exists(filepath):
        with open(filepath, "r", encoding="utf-8") as f:
            content = f.read()
        new_content = content.replace("/images/2-Proposal/", "/images/2-Proposal-workshop/")
        with open(filepath, "w", encoding="utf-8") as f:
            f.write(new_content)
