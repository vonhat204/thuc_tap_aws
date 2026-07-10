---
title: "Worklog Tuần 9"
date: 2025-10-06
weight: 9
chapter: false
pre: " <b> 1.9. </b> "
---

### Mục tiêu tuần 9:

* Đánh giá và quản lý điểm số bảo mật (Security Score) trên tài khoản AWS thông qua Security Hub.
* Thiết lập kết nối mạng ngang hàng giữa các VPC độc lập (VPC Peering) và cấu hình định tuyến liên mạng.

### Các công việc cần triển khai trong tuần này:

| Thứ | Công việc | Ngày bắt đầu | Ngày hoàn thành | Nguồn tài liệu |
| --- | --- | --- | --- | --- |
| 2 | - **Lab 18: AWS Security Hub** <br>&emsp; + Tìm hiểu các tiêu chuẩn bảo mật <br>&emsp; + Kích hoạt AWS Security Hub <br>&emsp; + Xem xét AWS Foundational Security Best Practices <br>&emsp; + Đánh giá tiêu chuẩn CIS AWS Foundations Benchmark <br>&emsp; + Phân tích điểm bảo mật (Security Score) | 15/06/2026 | 15/06/2026 | <https://000018.awsstudygroup.com/> |
| 3 | - **Lab 19 (Phần 1): Chuẩn bị hạ tầng VPC** <br>&emsp; + Khởi tạo hạ tầng (CloudFormation Template) <br>&emsp; + Thiết lập Mạng con và Bảng định tuyến <br>&emsp; + Khởi chạy máy chủ EC2 (Instance A & B) <br>&emsp; + Cập nhật Network ACL cho mạng con <br>&emsp; + Cấu hình Security Group cho EC2 | 16/06/2026 | 16/06/2026 | <https://000019.awsstudygroup.com/> |
| 4 | - **Lab 19 (Phần 2): VPC Peering Connection** <br>&emsp; + Khởi tạo VPC Peering Connection từ VPC nguồn <br>&emsp; + Chấp nhận kết nối Peering ở VPC đích <br>&emsp; + Cấu hình Route Table định tuyến qua Peering (VPC A) <br>&emsp; + Cấu hình Route Table định tuyến qua Peering (VPC B) | 17/06/2026 | 17/06/2026 | <https://000019.awsstudygroup.com/> |
| 5 | - **Lab 19 (Phần 3): Cross-Peer DNS & Kiểm thử** <br>&emsp; + Kích hoạt tính năng Cross-Peer DNS Resolution <br>&emsp; + Kiểm tra phân giải tên miền nội bộ chéo VPC <br>&emsp; + Truy cập SSH vào máy ảo EC2 <br>&emsp; + Ping kiểm tra giao tiếp ICMP giữa 2 máy ảo qua IP Private | 18/06/2026 | 18/06/2026 | <https://000019.awsstudygroup.com/> |
| 6 | - **Tổng kết tuần** <br>&emsp; + Đánh giá lại trạng thái bảo mật tổng thể <br>&emsp; + Xóa tài nguyên rác toàn diện (VPC, Peering, EC2) <br>&emsp; + Vô hiệu hóa Security Hub để tránh phát sinh phí <br>&emsp; + Viết báo cáo Worklog | 19/06/2026 | 19/06/2026 | |

### Kết quả đạt được tuần 9:

* **Lab 18: AWS Security Hub**
  * Kích hoạt thành công công cụ Security Hub với trạng thái "Enabled".
    ![Enable Security Hub](/images/worklog/week9/9.1_security_hub_enable.png)
  * Đánh giá Điểm bảo mật (Security Score) tóm tắt theo chuẩn CIS và AWS Foundational.
    ![Security Score](/images/worklog/week9/9.2_security_score.png)
  * Phân tích chi tiết các tiêu chuẩn bảo mật (Passed/Failed checks) của CIS Benchmark.
    ![CIS Benchmark Details](/images/worklog/week9/9.3_cis_benchmark.png)

* **Lab 19: VPC Peering**
  * Khởi tạo kiến trúc hạ tầng VPC và EC2 chạy ổn định ở 2 VPC khác nhau.
    ![VPC Architecture](/images/worklog/week9/9.4_vpc_architecture.png)
  * Thiết lập kết nối VPC Peering ở trạng thái "Active".
    ![VPC Peering Connection](/images/worklog/week9/9.5_vpc_peering.png)
  * Cấu hình Route Tables định tuyến thành công qua Peering Connection (pcx-...).
    ![Route Tables](/images/worklog/week9/9.6_route_tables.png)
  * Kích hoạt DNS chéo và Ping thành công từ EC2 này sang IP Private của EC2 kia.
    ![Ping Test](/images/worklog/week9/9.7_ping_test.png)