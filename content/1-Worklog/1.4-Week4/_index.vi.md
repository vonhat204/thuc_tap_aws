---
title: "Worklog Tuần 4"
date: 2026-04-20
weight: 4
chapter: false
pre: " <b> 1.4. </b> "
---

### Mục tiêu tuần 4:

* Triển khai khả năng mở rộng tự động và cân bằng tải cho hệ thống web.
* Lập ngân sách và quản lý chi phí AWS hiệu quả, đồng thời giám sát hệ thống với CloudWatch.

### Các công việc cần triển khai trong tuần này:
| Thứ | Công việc | Ngày bắt đầu | Ngày hoàn thành | Nguồn tài liệu |
| --- | --- | --- | --- | --- |
| 2 | - **Lab 6 (Phần 1): Thiết lập Load Balancer** <br>&emsp; + Thiết lập cơ sở hạ tầng mạng <br>&emsp; + Khởi tạo EC2 và RDS <br>&emsp; + Tạo mẫu khởi chạy (Launch Template) <br>&emsp; + Tạo nhóm mục tiêu & bộ cân bằng tải | 11/05/2026 | 11/05/2026 | <https://000006.awsstudygroup.com/> |
| 3 | - **Lab 6 (Phần 2): Auto Scaling** <br>&emsp; + Tạo Nhóm Tự động mở rộng <br>&emsp; + Kiểm tra mở rộng quy mô thủ công <br>&emsp; + Kiểm tra theo lịch trình & động <br>&emsp; + Xem chỉ số dự đoán | 12/05/2026 | 12/05/2026 | <https://000006.awsstudygroup.com/> |
| 4 | - **Lab 7: Quản lý ngân sách** <br>&emsp; + Lập ngân sách chi phí <br>&emsp; + Lập ngân sách sử dụng <br>&emsp; + Lập ngân sách RI <br>&emsp; + Kế hoạch tiết kiệm (Savings Plans) | 13/05/2026 | 13/05/2026 | <https://000007.awsstudygroup.com/> |
| 5 | - **Lab 8 (Phần 1): CloudWatch Metrics** <br>&emsp; + Đọc số liệu thống kê lượt xem <br>&emsp; + Sử dụng biểu thức tìm kiếm <br>&emsp; + Thông tin chi tiết về nhật ký (Log Insights) <br>&emsp; + Bộ lọc số liệu CloudWatch | 14/05/2026 | 14/05/2026 | <https://000008.awsstudygroup.com/> |
| 6 | - **Lab 8 (Phần 2): Cảnh báo & Dashboard** <br>&emsp; + Cấu hình Cảnh báo CloudWatch (Alarms) <br>&emsp; + Thiết kế Bảng điều khiển (Dashboard) <br>&emsp; + Dọn dẹp tài nguyên & viết Worklog | 15/05/2026 | 15/05/2026 | <https://000008.awsstudygroup.com/> |

### Kết quả đạt được tuần 4:

* **Lab 6: Cân bằng tải (ALB) và Auto Scaling**
  * Tạo thành công Launch Template và Target Group cho các phiên bản Web.
    ![Launch Template & Target Group](/images/worklog/week4/4.1_alb_tg.png)
  * Cấu hình Application Load Balancer hoạt động và chia tải chính xác.
    ![ALB Status](/images/worklog/week4/4.2_alb.png)
  * Xác minh tính năng Auto Scaling thủ công và theo lịch trình.
    ![ASG Status](/images/worklog/week4/4.3_asg.png)
  * Xác minh tính năng Auto Scaling động dựa trên mức độ tải của server.
    ![ASG Dynamic Scaling](/images/worklog/week4/4.4_asg_scaling.png)

* **Lab 7: Lập ngân sách và Chi phí**
  * Thiết lập thành công Ngân sách chi phí và Ngân sách sử dụng (Budgets).
    ![AWS Budgets](/images/worklog/week4/4.5_budget.png)
  * Triển khai Savings Plans và RI budgets để tối ưu hóa hóa đơn AWS.
    ![Savings Plans & RI budgets](/images/worklog/week4/4.5_budget.png)

* **Lab 8: Giám sát với CloudWatch**
  * Thu thập số liệu thống kê lượt xem và cấu hình Bộ lọc số liệu (Metric Filters).
    ![Metric Filters](/images/worklog/week4/4.6_cw_metrics.png)
  * Tạo cảnh báo (Alarms) phát thông báo khi thông số vượt quá ngưỡng.
    ![CloudWatch Alarms](/images/worklog/week4/4.7_cw_alarm.png)
  * Trực quan hóa toàn bộ chỉ số lên CloudWatch Dashboard một cách chuyên nghiệp.
    ![CloudWatch Dashboard](/images/worklog/week4/4.8_cw_dashboard.png)

