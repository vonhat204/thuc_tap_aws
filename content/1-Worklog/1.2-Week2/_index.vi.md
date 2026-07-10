---
title: "Worklog Tuần 2"
date: 2026-04-20
weight: 2
chapter: false
pre: " <b> 1.2. </b> "
---

### Mục tiêu tuần 2:

* Tìm hiểu và thực hành quản lý danh tính với IAM.
* Xây dựng hạ tầng mạng cơ bản với VPC và kết nối mạng riêng ảo VPN.

### Các công việc cần triển khai trong tuần này:
| Thứ | Công việc | Ngày bắt đầu | Ngày hoàn thành | Nguồn tài liệu |
| --- | --- | --- | --- | --- |
| 2 | - **Lab 2: Quản lý danh tính (IAM)** <br>&emsp; + Nhóm IAM và Người dùng IAM <br>&emsp; + Chính sách IAM và Vai trò IAM <br>&emsp; + Tạo nhóm quản trị viên <br>&emsp; + Tạo người dùng quản trị & vận hành <br>&emsp; + Đổi vai trò (Switch Role) | 27/04/2026 | 27/04/2026 | <https://000002.awsstudygroup.com/> |
| 3 | - **Lab 3 (Phần 1): Xây dựng hạ tầng VPC** <br>&emsp; + Tạo mạng con (Subnets) <br>&emsp; + Cấu hình Bảng định tuyến (Route Table) <br>&emsp; + Cổng Internet (Internet Gateway) <br>&emsp; + Cổng NAT (NAT Gateway) <br>&emsp; + Nhóm bảo mật (Security Group) | 28/04/2026 | 28/04/2026 | <https://000003.awsstudygroup.com/> |
| 4 | - **Lab 3 (Phần 2): Triển khai EC2** <br>&emsp; + Tạo máy chủ EC2 <br>&emsp; + Kiểm tra kết nối mạng <br>&emsp; + Sử dụng Systems Manager <br>&emsp; + Giám sát và cảnh báo CloudWatch | 29/04/2026 | 29/04/2026 | <https://000003.awsstudygroup.com/> |
| 5 | - **Lab 3 (Phần 3): Kết nối VPN** <br>&emsp; + Thiết lập VPN Site-to-Site <br>&emsp; + Cấu hình Cổng Khách hàng <br>&emsp; + Sử dụng Strongswan với Transit Gateway | 30/04/2026 | 30/04/2026 | <https://000003.awsstudygroup.com/> |
| 6 | - **Tổng kết tuần** <br>&emsp; + Kiểm tra các lỗi thường gặp <br>&emsp; + Dọn dẹp tài nguyên Lab 2 & 3 <br>&emsp; + Viết báo cáo Worklog | 01/05/2026 | 01/05/2026 | <https://000002.awsstudygroup.com/> |

### Kết quả đạt được tuần 2:

* **Lab 2: Quản lý danh tính (IAM)**
  * Tạo thành công Nhóm Quản trị viên và phân quyền (Policies).
    ![IAM User Group](/images/worklog/week2/2.1.png)
  * Tạo thành công Người dùng Quản trị & Vận hành.
    ![IAM Users](/images/worklog/week2/2.2.png)
  * Thực hiện chuyển đổi vai trò (Switch Role) thành công.
    ![Switch Role](/images/worklog/week2/2.3.png)

* **Lab 3 (Phần 1): Xây dựng hạ tầng VPC**
  * Cấu hình Mạng con (Subnets) và Bảng định tuyến (Route Table).
    ![VPC Subnets & Route Table](/images/worklog/week2/2.4.png)
  * Khởi tạo thành công Internet Gateway và NAT Gateway.
    ![Internet Gateway & NAT Gateway](/images/worklog/week2/2.4.png)
  * Thiết lập các Nhóm bảo mật (Security Group) theo đúng chuẩn.
    ![Security Group](/images/worklog/week2/2.5.png)

* **Lab 3 (Phần 2 & 3): Triển khai EC2 & Kết nối VPN**
  * Khởi chạy máy chủ EC2 và kiểm tra kết nối mạng (Reachability Analyzer).
    ![EC2 Instances](/images/worklog/week2/2.6.png)
  * Giám sát hệ thống từ CloudWatch / Systems Manager.
    ![CloudWatch Alarm](/images/worklog/week2/2.7.png)
  * Cấu hình và thiết lập kết nối VPN Site-to-Site thành công.
    ![VPN Connection](/images/worklog/week2/2.8.png)

