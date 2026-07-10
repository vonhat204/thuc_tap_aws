---
title: "Worklog Tuần 7"
date: 2026-04-20
weight: 7
chapter: false
pre: " <b> 1.7. </b> "
---

### Mục tiêu tuần 7:

* Trải nghiệm quy trình di chuyển máy ảo (VMWare) lên đám mây AWS.
* Làm quen với Container hóa ứng dụng bằng Docker và Elastic Container Service (ECS).

### Các công việc cần triển khai trong tuần này:
| Thứ | Công việc | Ngày bắt đầu | Ngày hoàn thành | Nguồn tài liệu |
| --- | --- | --- | --- | --- |
| 2 | - **Lab 14: VMWare to AWS** <br>&emsp; + Xuất máy ảo từ máy chủ cục bộ <br>&emsp; + Nhập máy ảo vào AWS & triển khai <br>&emsp; + Xuất phiên bản từ AWS ra file <br>&emsp; + Thiết lập ACL cho bucket S3 | 01/06/2026 | 01/06/2026 | <https://000014.awsstudygroup.com/> |
| 3 | - **Lab 15 (Phần 1): Docker & ECR** <br>&emsp; + Cài đặt các phần phụ thuộc Docker <br>&emsp; + Triển khai thử nghiệm trên máy cục bộ <br>&emsp; + Tạo vai trò IAM truy cập ECR <br>&emsp; + Đăng nhập & push image lên Docker Hub / ECR | 02/06/2026 | 02/06/2026 | <https://000015.awsstudygroup.com/> |
| 4 | - **Lab 15 (Phần 2): Cấu hình môi trường** <br>&emsp; + Khởi chạy nhóm mạng con cơ sở dữ liệu <br>&emsp; + Khởi chạy RDS <br>&emsp; + Cấu hình máy chủ EC2 (cài đặt thư viện) | 03/06/2026 | 03/06/2026 | <https://000015.awsstudygroup.com/> |
| 5 | - **Lab 15 (Phần 3): Triển khai Container** <br>&emsp; + Triển khai ứng dụng chỉ sử dụng ảnh Docker <br>&emsp; + Triển khai bằng Docker Compose <br>&emsp; + Kiểm thử ứng dụng | 04/06/2026 | 04/06/2026 | <https://000015.awsstudygroup.com/> |
| 6 | - **Tổng kết tuần** <br>&emsp; + Tối ưu hóa Docker Image <br>&emsp; + Dọn dẹp tài nguyên diện rộng <br>&emsp; + Hoàn thiện Worklog | 05/06/2026 | 05/06/2026 | |

### Kết quả đạt được tuần 7:

* **Lab 14: Di chuyển máy ảo VMWare**
  * Export thành công VM từ máy chủ cục bộ và upload lên S3.
    ![S3 Upload](/images/worklog/week7/7.1_vm_s3.png)
  * Chạy tiến trình Import máy ảo từ S3 vào AWS EC2 và khởi chạy Instance.
    ![Import VM](/images/worklog/week7/7.2_vm_import.png)
  * Export ngược lại phiên bản EC2 từ AWS xuống dưới dạng file VMDK/OVA.
    ![Export VM](/images/worklog/week7/7.3_vm_export.png)

* **Lab 15: Ứng dụng Container với Docker**
  * Đóng gói mã nguồn thành Docker Image và chạy thử nghiệm thành công ở Local.
    ![Docker Local](/images/worklog/week7/7.4_docker_local.png)
  * Xác thực IAM và Push Image lên Elastic Container Registry (ECR).
    ![ECR Push](/images/worklog/week7/7.5_ecr_push.png)
  * Kết nối thành công Container tới dịch vụ cơ sở dữ liệu RDS bên ngoài.
    ![RDS Connect](/images/worklog/week7/7.6_rds_connect.png)
  * Triển khai cụm dịch vụ hoàn chỉnh trên EC2 sử dụng tệp `docker-compose.yml`.
    ![Docker Compose](/images/worklog/week7/7.7_docker_compose.png)

