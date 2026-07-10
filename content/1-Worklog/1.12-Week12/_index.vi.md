---
title: "Worklog Tuần 12"
date: 2025-10-27
weight: 12
chapter: false
pre: " <b> 1.12. </b> "
---

### Mục tiêu tuần 12:

* Triển khai giải pháp lưu trữ lai (Hybrid Storage) với AWS Storage Gateway.
* Bảo mật ứng dụng Web bằng Tường lửa AWS WAF chống lại các lỗ hổng phổ biến.
* Quản lý tài nguyên AWS hiệu quả bằng Tags và Resource Groups.

### Các công việc cần triển khai trong tuần này:

| Thứ | Công việc | Ngày bắt đầu | Ngày hoàn thành | Nguồn tài liệu |
| --- | --- | --- | --- | --- |
| 2 | - **Lab 24: AWS Storage Gateway** <br>&emsp; + Tạo máy ảo Storage Gateway trên EC2 <br>&emsp; + Cấu hình S3 File Shares <br>&emsp; + Kết nối (Mount) File Share vào máy cục bộ <br>&emsp; + Upload file để đồng bộ dữ liệu lên S3 | 06/07/2026 | 06/07/2026 | <https://000024.awsstudygroup.com/> |
| 3 | - **Lab 26: Bảo mật AWS WAF** <br>&emsp; + Triển khai ứng dụng Web mẫu và ALB <br>&emsp; + Cấu hình Web ACLs và Managed Rules <br>&emsp; + Viết Custom Rules chặn IP/Quốc gia cụ thể <br>&emsp; + Bật Logging giám sát tấn công | 07/07/2026 | 07/07/2026 | <https://000026.awsstudygroup.com/> |
| 4 | - **Lab 27: Resource Groups & Tags** <br>&emsp; + Tạo EC2 Instance với các Tag <br>&emsp; + Quản lý Tags trên AWS Resources <br>&emsp; + Lọc tài nguyên bằng Tag <br>&emsp; + Tạo Resource Group | 08/07/2026 | 08/07/2026 | <https://000027.awsstudygroup.com/> |
| 5 | - **Tổng kết & Dọn dẹp cuối khóa** <br>&emsp; + Kiểm tra các báo cáo thực tập (Worklog) <br>&emsp; + Xóa triệt để Storage Gateway, WAF và Resource Groups <br>&emsp; + Tổng kết khóa thực tập AWS | 09/07/2026 | 09/07/2026 | |

### Kết quả đạt được tuần 12:

* **Lab 24: AWS Storage Gateway**
  * Khởi chạy hoàn tất phiên bản máy ảo File Gateway trên EC2 Instance.
    ![File Gateway VM](/images/worklog/week12/12.1_file_gateway_vm.png)
  * Khởi tạo máy ảo File Gateway và ánh xạ (Mount) thành công thành ổ đĩa cục bộ trên Windows.
    ![Storage Gateway Mount](/images/worklog/week12/12.2_storage_gateway.png)
  * File được tải lên thư mục Mount cục bộ tự động đồng bộ lên S3 Bucket an toàn.
    ![S3 Sync](/images/worklog/week12/12.3_s3_sync.png)

* **Lab 26: AWS WAF**
  * Triển khai thành công Web ACLs tích hợp vào Application Load Balancer để bảo vệ ứng dụng.
    ![WAF Web ACL](/images/worklog/week12/12.4_waf_acl.png)
  * Cấu hình Custom Rules & Managed Rules chống lại các lỗ hổng phổ biến (SQLi, XSS).
    ![WAF Rules](/images/worklog/week12/12.5_waf_rules.png)
  * WAF chặn (Block) thành công các truy cập trái phép và hiển thị Traffic Metrics.
    ![WAF Blocked Traffic](/images/worklog/week12/12.6_waf_blocked.png)

* **Lab 27: Resource Groups & Tags**
  * Tạo EC2 Instance thành công với các Tag cơ bản (Environment, Project).
    ![EC2 Tags](/images/worklog/week12/12.7_ec2_tags.png)
  * Quản lý và lọc tài nguyên dễ dàng thông qua Tag Editor.
    ![Tag Editor](/images/worklog/week12/12.8_tag_editor.png)
  * Tạo AWS Resource Group tự động gom nhóm các tài nguyên theo Tag.
    ![Resource Group](/images/worklog/week12/12.9_resource_group.png)
