---
title: "Worklog Tuần 5"
date: 2026-04-20
weight: 5
chapter: false
pre: " <b> 1.5. </b> "
---

### Mục tiêu tuần 5:

* Hiểu về các gói hỗ trợ của AWS.
* Sử dụng AWS CLI để quản trị tự động các tài nguyên và quản lý đa tài khoản với AWS Organizations.

### Các công việc cần triển khai trong tuần này:
| Thứ | Công việc | Ngày bắt đầu | Ngày hoàn thành | Nguồn tài liệu |
| --- | --- | --- | --- | --- |
| 2 | - **Lab 9: Gói hỗ trợ AWS** <br>&emsp; + Tìm hiểu các gói hỗ trợ <br>&emsp; + Quản lý yêu cầu hỗ trợ (Support Ticket) <br> - **Lab 11: Cài đặt AWS CLI** <br>&emsp; + Cài đặt & cấu hình CLI <br>&emsp; + Xem tài nguyên thông qua CLI | 18/05/2026 | 18/05/2026 | <https://000009.awsstudygroup.com/> |
| 3 | - **Lab 11 (Tiếp theo): Quản lý qua CLI** <br>&emsp; + AWS CLI với S3 & SNS <br>&emsp; + AWS CLI với IAM <br>&emsp; + AWS CLI với VPC & Internet Gateway <br>&emsp; + Khởi tạo EC2 bằng dòng lệnh | 19/05/2026 | 19/05/2026 | <https://000011.awsstudygroup.com/> |
| 4 | - **Lab 12 (Phần 1): AWS Organizations** <br>&emsp; + Tạo tài khoản AWS trong tổ chức <br>&emsp; + Thiết lập đơn vị tổ chức (OU) <br>&emsp; + Mời tài khoản AWS vào tổ chức <br>&emsp; + Truy cập tài khoản thành viên | 20/05/2026 | 20/05/2026 | <https://000012.awsstudygroup.com/> |
| 5 | - **Lab 12 (Phần 2): Kiểm soát & Nhận dạng** <br>&emsp; + Chính sách do khách hàng quản lý (SCP) <br>&emsp; + Kiểm soát truy cập dựa trên thời gian <br>&emsp; + Trung tâm định danh IAM (SSO) | 21/05/2026 | 21/05/2026 | <https://000012.awsstudygroup.com/> |
| 6 | - **Tổng kết tuần** <br>&emsp; + Thực hành khắc phục sự cố CLI <br>&emsp; + Dọn dẹp tài nguyên đa tài khoản <br>&emsp; + Báo cáo Worklog | 22/05/2026 | 22/05/2026 | |

### Kết quả đạt được tuần 5:

* **Lab 9 & Lab 11: Hỗ trợ AWS và CLI**
  * Tạo yêu cầu hỗ trợ (Support Ticket) giả định trên giao diện AWS.
    ![Support Ticket](/images/worklog/week5/5.1_support.png)
  * Khởi tạo profile AWS CLI thành công trên máy trạm nội bộ.
    ![CLI Profile](/images/worklog/week5/5.2_cli_profile.png)
  * Thao tác tạo Bucket S3 và gửi thông báo SNS trực tiếp bằng lệnh CLI.
    ![S3 & SNS via CLI](/images/worklog/week5/5.3_cli_s3_sns.png)
  * Triển khai VPC, Internet Gateway và khởi chạy EC2 hoàn toàn bằng lệnh.
    ![VPC & EC2 via CLI](/images/worklog/week5/5.4_cli_vpc_ec2.png)

* **Lab 12: AWS Organizations**
  * Thiết lập cấu trúc Đơn vị tổ chức (OU) và mời tài khoản thành viên thành công.
    ![Organizations & OU](/images/worklog/week5/5.5_org_ou.png)
  * Chuyển đổi và truy cập vào tài khoản thành viên một cách an toàn.
    ![Switch Account](/images/worklog/week5/5.6_org_switch.png)
  * Gắn và xác minh hiệu lực của Service Control Policies (SCP) để giới hạn quyền.
    ![SCP Config](/images/worklog/week5/5.7_org_scp.png)
  * Đăng nhập tập trung một lần thông qua IAM Identity Center (SSO).
    ![IAM Identity Center SSO](/images/worklog/week5/5.8_sso.png)

