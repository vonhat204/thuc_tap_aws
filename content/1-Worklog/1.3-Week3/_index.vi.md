---
title: "Worklog Tuần 3"
date: 2026-04-20
weight: 3
chapter: false
pre: " <b> 1.3. </b> "
---

### Mục tiêu tuần 3:

* Triển khai máy chủ ứng dụng thực tế trên môi trường Linux và Windows.
* Thiết lập hệ quản trị cơ sở dữ liệu quan hệ (RDS) và kết nối với máy chủ ứng dụng.

### Các công việc cần triển khai trong tuần này:
| Thứ | Công việc | Ngày bắt đầu | Ngày hoàn thành | Nguồn tài liệu |
| --- | --- | --- | --- | --- |
| 2 | - **Lab 4 (Phần 1): Khởi chạy EC2** <br>&emsp; + Tạo VPC Linux / Windows <br>&emsp; + Khởi chạy Windows Server 2025 <br>&emsp; + Khởi chạy Amazon Linux <br>&emsp; + Tạo và quản lý ảnh chụp nhanh EBS <br>&emsp; + Tạo AMI tùy chỉnh | 04/05/2026 | 04/05/2026 | <https://000004.awsstudygroup.com/> |
| 3 | - **Lab 4 (Phần 2): Triển khai ứng dụng** <br>&emsp; + Cài đặt LAMP trên Amazon Linux <br>&emsp; + Triển khai ứng dụng quản lý trên Linux <br>&emsp; + Cài đặt Node.js trên Windows <br>&emsp; + Triển khai ứng dụng trên Windows | 05/05/2026 | 05/05/2026 | <https://000004.awsstudygroup.com/> |
| 4 | - **Lab 4 (Phần 3): Quản lý chi phí với IAM** <br>&emsp; + Hạn chế sử dụng dịch vụ theo khu vực <br>&emsp; + Giới hạn việc sử dụng EC2 theo loại <br>&emsp; + Quản lý các loại lưu trữ ổ đĩa EBS <br>&emsp; + Giới hạn quyền xóa tài nguyên | 06/05/2026 | 06/05/2026 | <https://000004.awsstudygroup.com/> |
| 5 | - **Lab 5: Triển khai ứng dụng Web & DB** <br>&emsp; + Thiết lập nhóm mạng con cơ sở dữ liệu <br>&emsp; + Tạo phiên bản EC2 & RDS <br>&emsp; + Triển khai ứng dụng kết nối DB <br>&emsp; + Sao lưu và phục hồi dữ liệu | 07/05/2026 | 07/05/2026 | <https://000005.awsstudygroup.com/> |
| 6 | - **Tổng kết tuần** <br>&emsp; + Kiểm tra lại các ứng dụng đã triển khai <br>&emsp; + Dọn dẹp tài nguyên Lab 4 & 5 <br>&emsp; + Hoàn thiện Worklog | 08/05/2026 | 08/05/2026 | <https://000004.awsstudygroup.com/> |

### Kết quả đạt được tuần 3:

* **Lab 4 (Phần 1): EC2 & Quản lý EBS/AMI**
  * Khởi chạy thành công Windows Server 2025 và Amazon Linux.
    ![EC2 Instances](/images/worklog/week3/3.1_ec2.png)
  * Tạo bản sao lưu tự động (EBS Snapshot) và tạo AMI tùy chỉnh.
    ![EBS Snapshot & AMI](/images/worklog/week3/3.2_snapshot.png)
  * Khôi phục thành công quyền truy cập vào các phiên bản EC2.
    ![Custom AMI](/images/worklog/week3/3.2_ami.png)

* **Lab 4 (Phần 2): Triển khai Web App**
  * Cài đặt LAMP và Node.js thành công trên EC2 Amazon Linux.
    ![Linux Web App](/images/worklog/week3/3.3_linux.png)
  * Cấu hình XAMPP và Node.js thành công trên EC2 Windows.
    ![Windows Web App](/images/worklog/week3/3.3_windows.png)
  * Ứng dụng Quản lý người dùng AWS chạy ổn định trên cả 2 nền tảng.
    ![Web Apps Running](/images/worklog/week3/3.3_linux.png)

* **Lab 4 & Lab 5: Quản lý chi phí & RDS Database**
  * Kiểm thử thành công các chính sách giới hạn IAM (Giới hạn region, loại EC2).
    ![IAM Restriction Test](/images/worklog/week3/3.5_iam_policy.png)
  * Cấu hình thành công Subnet Group cho Database và khởi chạy máy chủ RDS.
    ![RDS Database](/images/worklog/week3/3.4_rds.png)
  * Ứng dụng EC2 kết nối thành công vào RDS và thực hiện được luồng sao lưu/phục hồi.
    ![RDS Connection](/images/worklog/week3/3.4_rds.png)

