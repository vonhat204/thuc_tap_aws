---
title: "Worklog Tuần 8"
date: 2026-04-20
weight: 8
chapter: false
pre: " <b> 1.8. </b> "
---

### Mục tiêu tuần 8:

* Triển khai hệ thống microservices lên cụm ECS tích hợp Load Balancer.
* Xây dựng luồng CI/CD tự động hóa việc triển khai mã nguồn.

### Các công việc cần triển khai trong tuần này:
| Thứ | Công việc | Ngày bắt đầu | Ngày hoàn thành | Nguồn tài liệu |
| --- | --- | --- | --- | --- |
| 2 | - **Lab 16 (Phần 1): Cụm ECS & Cloud Map** <br>&emsp; + Đăng ký không gian tên trong Cloud Map <br>&emsp; + Tạo cụm ECS <br>&emsp; + Tạo định nghĩa tác vụ (Task Definition) <br>&emsp; + Đẩy hình ảnh lên ECR | 08/06/2026 | 08/06/2026 | <https://000016.awsstudygroup.com/> |
| 3 | - **Lab 16 (Phần 2): Load Balancer & ECS Service** <br>&emsp; + Cấu hình Application Load Balancer <br>&emsp; + Tạo dịch vụ ECS <br>&emsp; + Triển khai Blue/Green với hệ thống Backend <br>&emsp; + Triển khai Rolling với Frontend | 09/06/2026 | 09/06/2026 | <https://000016.awsstudygroup.com/> |
| 4 | - **Lab 17 (Phần 1): CI/CD với GitLab/GitHub** <br>&emsp; + Cài đặt và đăng ký GitLab Runner <br>&emsp; + Chạy quy trình CI/CD GitLab <br>&emsp; + Tạo khóa truy cập & đẩy code lên GitHub <br>&emsp; + Triển khai GitHub Actions | 10/06/2026 | 10/06/2026 | <https://000017.awsstudygroup.com/> |
| 5 | - **Lab 17 (Phần 2): AWS CodeBuild & Logging** <br>&emsp; + Tạo CodeBuild cho Frontend / Backend <br>&emsp; + Thiết lập Container Insights (CloudWatch) <br>&emsp; + Tạo bộ định tuyến nhật ký Firelens <br>&emsp; + Cập nhật dịch vụ ECS để test log | 11/06/2026 | 11/06/2026 | <https://000017.awsstudygroup.com/> |
| 6 | - **Tổng kết tuần** <br>&emsp; + Kiểm tra kết quả CI/CD Pipeline <br>&emsp; + Xóa tài nguyên rác toàn diện <br>&emsp; + Viết báo cáo Worklog | 12/06/2026 | 12/06/2026 | |

### Kết quả đạt được tuần 8:

* **Lab 16: ECS & Load Balancer**
  * Khởi tạo thành công Cụm ECS (ECS Cluster) và Đăng ký Namespace trong Cloud Map.
    ![ECS Cluster](/images/worklog/week8/8.1_ecs_cluster.png)
  * Tạo Task Definition và gắn kết Application Load Balancer vào ECS Service.
    ![ECS Task Definition](/images/worklog/week8/8.2_ecs_taskdef.png)
  * Triển khai an toàn Backend bằng phương pháp Blue/Green Deployment.
    ![Blue/Green Deployment](/images/worklog/week8/8.3_ecs_bluegreen.png)
  * Cập nhật bản vá Frontend bằng phương pháp Rolling Update.
    ![Rolling Update](/images/worklog/week8/8.4_ecs_rolling.png)

* **Lab 17: Hệ thống CI/CD & Giám sát**
  * Đăng ký thành công GitLab Runner và chạy Pipeline tự động build Image.
    ![GitLab Runner & Targets](/images/worklog/week8/8.5_gitlab_runner.png)
  * Tích hợp GitHub Actions và AWS CodeBuild để triển khai luồng Continuous Deployment.
    ![CodeBuild](/images/worklog/week8/8.6_codebuild.png)
  * Cấu hình AWS Firelens để định tuyến log của Container về S3.
    ![Cloud Map DNS](/images/worklog/week8/8.7_firelens.png)
  * Giám sát tài nguyên CPU/Memory của từng Task qua CloudWatch Container Insights.
    ![Container Insights](/images/worklog/week8/8.8_container_insights.png)

