---
title: "Worklog Tuần 6"
date: 2026-04-20
weight: 6
chapter: false
pre: " <b> 1.6. </b> "
---

### Mục tiêu tuần 6:

* Thiết lập dịch vụ thư mục (Microsoft AD) và định tuyến DNS với Route 53.
* Xây dựng chiến lược dự phòng, sao lưu và khôi phục dữ liệu trên S3.

### Các công việc cần triển khai trong tuần này:
| Thứ | Công việc | Ngày bắt đầu | Ngày hoàn thành | Nguồn tài liệu |
| --- | --- | --- | --- | --- |
| 2 | - **Lab 10 (Phần 1): Triển khai hạ tầng** <br>&emsp; + Khởi tạo mẫu CloudFormation <br>&emsp; + Tạo cặp khóa & cấu hình SG <br>&emsp; + Kết nối với Remote Desktop Gateway (RDGW) | 25/05/2026 | 25/05/2026 | <https://000010.awsstudygroup.com/> |
| 3 | - **Lab 10 (Phần 2): Microsoft AD & Route 53** <br>&emsp; + Triển khai Microsoft AD <br>&emsp; + Tạo điểm cuối Inbound / Outbound <br>&emsp; + Cấu hình quy tắc giải quyết DNS | 26/05/2026 | 26/05/2026 | <https://000010.awsstudygroup.com/> |
| 4 | - **Lab 13 (Phần 1): Hạ tầng Backup** <br>&emsp; + Tạo nhóm lưu trữ S3 <br>&emsp; + Triển khai cơ sở hạ tầng mạng cơ bản | 27/05/2026 | 27/05/2026 | <https://000013.awsstudygroup.com/> |
| 5 | - **Lab 13 (Phần 2): Kế hoạch dự phòng** <br>&emsp; + Thiết lập lập kế hoạch dự phòng <br>&emsp; + Cấu hình cảnh báo thông báo <br>&emsp; + Kiểm tra tính năng Khôi phục (Restore) | 28/05/2026 | 28/05/2026 | <https://000013.awsstudygroup.com/> |
| 6 | - **Tổng kết tuần** <br>&emsp; + Đánh giá kết quả DNS phân giải <br>&emsp; + Dọn dẹp tài nguyên Lab 10 & 13 <br>&emsp; + Viết báo cáo Worklog | 29/05/2026 | 29/05/2026 | <https://000010.awsstudygroup.com/> |

### Kết quả đạt được tuần 6:

* **Lab 10: Microsoft AD & Route 53**
  * Triển khai nhanh cơ sở hạ tầng bằng mẫu CloudFormation.
    ![CloudFormation Stacks](/images/worklog/week6/6.1_cfn.png)
  * Cấu hình và kết nối thành công tới Remote Desktop Gateway (RDGW).
    ![RDGW Connection](/images/worklog/week6/6.2_rdgw.png)
  * Khởi tạo máy chủ Microsoft Active Directory trên AWS và kết nối hệ thống.
    ![Active Directory](/images/worklog/week6/6.3_ad.png)
  * Tạo Inbound/Outbound Endpoints trong Route 53 để phân giải tên miền lai.
    ![Route 53 Resolver Endpoints](/images/worklog/week6/6.4_r53_endpoints.png)

* **Lab 13: S3 Backup & Restore**
  * Cấu hình S3 Buckets chuyên dụng để lưu trữ dữ liệu dự phòng.
    ![S3 Backup Bucket](/images/worklog/week6/6.5_s3_backup.png)
  * Tạo và kích hoạt thành công Backup Plan để sao lưu định kỳ.
    ![Backup Plan](/images/worklog/week6/6.6_backup_plan.png)
  * Mô phỏng mất dữ liệu và chạy quy trình Restore (Khôi phục) thành công.
    ![Restore Job](/images/worklog/week6/6.7_backup_restore.png)

