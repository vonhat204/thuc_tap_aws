---
title: "Worklog Tuần 1"
date: 2024-01-01
weight: 1
chapter: false
pre: " <b> 1.1. </b> "
---


### Mục tiêu tuần 1:

* Kết nối, làm quen với các thành viên trong First Cloud AI Journey.
* Hiểu dịch vụ AWS cơ bản, cách dùng console & CLI.

### Các công việc cần triển khai trong tuần này:
| Thứ | Công việc                                                                                                                                                                                   | Ngày bắt đầu | Ngày hoàn thành | Nguồn tài liệu                            |
| --- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------ | --------------- | ----------------------------------------- |
| 2   | - Làm quen với các thành viên FCAJ <br> - Đọc và lưu ý các nội quy, quy định tại đơn vị thực tập                                                                                             | 20/04/2026 | 20/04/2026 | | 3   | - Tìm hiểu AWS và các loại dịch vụ <br>&emsp; + Compute <br>&emsp; + Storage <br>&emsp; + Networking <br>&emsp; + Database <br>&emsp; + ... <br>                                            | 21/04/2026 | 21/04/2026 | <https://000001.awsstudygroup.com/> |
| 4   | - Tạo AWS Free Tier account <br> - Tìm hiểu AWS Console & AWS CLI <br> - **Thực hành:** <br>&emsp; + Tạo AWS account <br>&emsp; + Cài AWS CLI & cấu hình <br> &emsp; + Cách sử dụng AWS CLI | 22/04/2026 | 22/04/2026 | <https://000001.awsstudygroup.com/> |
| 5   | - Tìm hiểu EC2 cơ bản: <br>&emsp; + Instance types <br>&emsp; + AMI <br>&emsp; + EBS <br>&emsp; + ... <br> - Các cách remote SSH vào EC2 <br> - Tìm hiểu Elastic IP   <br>                  | 23/04/2026 | 23/04/2026 | <https://000001.awsstudygroup.com/> |
| 6   | - **Thực hành:** <br>&emsp; + Tạo EC2 instance <br>&emsp; + Kết nối SSH <br>&emsp; + Gắn EBS volume                                                                                         | 24/04/2026 | 24/04/2026 | <https://000001.awsstudygroup.com/> |


### Kết quả đạt được tuần 1:

* Hiểu AWS là gì và nắm được các nhóm dịch vụ cơ bản (Compute, Storage, Networking, Database...).
* Đã tạo và cấu hình AWS Free Tier account thành công.
* Làm quen với AWS Management Console và biết cách tìm, truy cập, sử dụng dịch vụ từ giao diện web.

* Cài đặt và cấu hình AWS CLI trên máy tính thành công:
  ![Cấu hình AWS CLI](/images/worklog/week1/1.1_aws_cli_config.png)

* **Thực hành khởi tạo và quản lý EC2:**
  * Khởi tạo máy ảo EC2 (t2.micro) với hệ điều hành Amazon Linux 2023.
    ![Khởi tạo EC2](/images/worklog/week1/1.2_ec2_console.png)
  * Khởi tạo và gắn thành công ổ đĩa EBS vào máy ảo EC2.
    ![Gắn EBS](/images/worklog/week1/1.3_ebs_attached.png)
  * Sử dụng SSH Key Pair kết nối thành công vào máy ảo EC2 từ Terminal (CLI).
    ![Kết nối SSH](/images/worklog/week1/1.4_ssh_connection.png)


