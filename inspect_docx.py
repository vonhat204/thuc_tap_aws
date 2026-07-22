import docx

doc = docx.Document('1-Phieu-Theo-doi-Tien-do-TTTN (7).docx')

with open('table_layout.txt', 'w', encoding='utf-8') as f:
    for i, table in enumerate(doc.tables):
        f.write(f"Table {i}:\n")
        for j, row in enumerate(table.rows):
            cells = [cell.text.replace('\n', ' ')[:30] for cell in row.cells]
            f.write(f"  Row {j}: {cells}\n")
