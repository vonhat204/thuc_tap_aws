---
title: "Worklog Tuần 10"
date: 2025-10-13
weight: 10
chapter: false
pre: " <b> 1.10. </b> "
---

### Mục tiêu tuần 10:

* Xây dựng kiến trúc mạng hub-and-spoke kết nối nhiều VPC tập trung bằng AWS Transit Gateway.
* Viết hàm AWS Lambda và tích hợp Webhook để gửi thông báo tự động về trạng thái EC2 sang Slack.

### Các công việc cần triển khai trong tuần này:

| Thứ | Công việc | Ngày bắt đầu | Ngày hoàn thành | Nguồn tài liệu |
| --- | --- | --- | --- | --- |
| 2 | - **Lab 20 (Phần 1): Hạ tầng Transit Gateway** <br>&emsp; + Khởi tạo 3 VPC độc lập (VPC A, B, C) <br>&emsp; + Tạo EC2 Instances ở các mạng khác nhau <br>&emsp; + Khởi tạo AWS Transit Gateway (TGW) | 22/06/2026 | 22/06/2026 | <https://000020.awsstudygroup.com/> |
| 3 | - **Lab 20 (Phần 2): Định tuyến TGW** <br>&emsp; + Tạo TGW Attachments kết nối các VPC <br>&emsp; + Cấu hình TGW Route Tables <br>&emsp; + Cập nhật VPC Route Tables <br>&emsp; + Kiểm tra giao tiếp liên mạng qua TGW | 23/06/2026 | 23/06/2026 | <https://000020.awsstudygroup.com/> |
| 4 | - **Lab 22 (Phần 1): AWS Lambda & EventBridge** <br>&emsp; + Cấu hình IAM Role cho Lambda <br>&emsp; + Khởi tạo hàm AWS Lambda bằng Python/Node.js <br>&emsp; + Tạo quy tắc EventBridge bắt sự kiện trạng thái EC2 | 24/06/2026 | 24/06/2026 | <https://000022.awsstudygroup.com/> |
| 5 | - **Lab 22 (Phần 2): Tích hợp Slack Webhook** <br>&emsp; + Tạo kênh Slack và cấu hình Incoming Webhooks <br>&emsp; + Tích hợp URL Webhook vào biến môi trường Lambda <br>&emsp; + Khởi động/Dừng EC2 để kích hoạt cảnh báo | 25/06/2026 | 25/06/2026 | <https://000022.awsstudygroup.com/> |
| 6 | - **Tổng kết tuần** <br>&emsp; + Đánh giá mô hình Hub-and-Spoke của TGW <br>&emsp; + Xóa toàn bộ tài nguyên rác (TGW, EC2, VPC, Lambda) <br>&emsp; + Viết báo cáo Worklog | 26/06/2026 | 26/06/2026 | |

### Kết quả đạt được tuần 10:

* **Lab 20: AWS Transit Gateway**
  * Triển khai hoàn thiện 3 VPC riêng biệt cùng các EC2 Instances bên trong.
    ![VPCs and EC2s](/images/worklog/week10/10.1_vpcs_ec2.png)
  * Khởi tạo thành công TGW Resource ở trạng thái Available.
    ![Transit Gateway](/images/worklog/week10/10.2_transit_gateway.png)
  * Tạo thành công các TGW Attachments gắn kết 3 VPC vào Gateway trung tâm.
    ![TGW Attachments](/images/worklog/week10/10.3_tgw_attachments.png)
  * Thiết lập định tuyến TGW Route Tables và Ping thành công giữa các EC2 Instances.
    ![TGW Routing & Ping Test](/images/worklog/week10/10.4_tgw_ping.png)

* **Lab 22: Serverless Notification (Lambda & Slack)**
  * Cấu hình chuẩn xác IAM Role cấp quyền thực thi cho Lambda Function.
    ![IAM Role for Lambda](/images/worklog/week10/10.5_iam_role.png)
  * Triển khai thành công hàm AWS Lambda kết hợp với EventBridge rule.
    ![AWS Lambda](/images/worklog/week10/10.6_lambda_function.png)
  * Mã nguồn Lambda (Python/Node.js) được deploy và tích hợp Webhook URL.
    ![Lambda Code & Webhook](/images/worklog/week10/10.7_lambda_code.png)
  * Nhận được tin nhắn cảnh báo trạng thái EC2 tự động trên kênh Slack.
    ![Slack Notification](/images/worklog/week10/10.8_slack_alert.png)