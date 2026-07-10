---
title: "Worklog Tuần 11"
date: 2025-10-20
weight: 11
chapter: false
pre: " <b> 1.11. </b> "
---

### Mục tiêu tuần 11:

* Xây dựng luồng CI/CD (Tích hợp & Phân phối liên tục) tự động hoàn toàn bằng các dịch vụ AWS Native.
* Khám phá chuỗi công cụ AWS Developer Tools: CodeCommit, CodeBuild, CodeDeploy và CodePipeline.

### Các công việc cần triển khai trong tuần này:

| Thứ | Công việc | Ngày bắt đầu | Ngày hoàn thành | Nguồn tài liệu |
| --- | --- | --- | --- | --- |
| 2 | - **Lab 23 (Phần 1): Source Code & Môi trường** <br>&emsp; + Thiết lập Amazon S3 Bucket chứa Artifacts <br>&emsp; + Cấu hình IAM Roles cho dịch vụ CI/CD <br>&emsp; + Tạo kho lưu trữ AWS CodeCommit <br>&emsp; + Đẩy mã nguồn ứng dụng mẫu lên kho lưu trữ | 29/06/2026 | 29/06/2026 | <https://000023.awsstudygroup.com/> |
| 3 | - **Lab 23 (Phần 2): AWS CodeBuild** <br>&emsp; + Khởi tạo dự án AWS CodeBuild <br>&emsp; + Tạo file `buildspec.yml` đóng gói ứng dụng <br>&emsp; + Liên kết CodeBuild với CodeCommit và chạy thử | 30/06/2026 | 30/06/2026 | <https://000023.awsstudygroup.com/> |
| 4 | - **Lab 23 (Phần 3): Môi trường EC2 & CodeDeploy** <br>&emsp; + Khởi chạy EC2 Target Server <br>&emsp; + Cài đặt CodeDeploy Agent trên EC2 <br>&emsp; + Cấu hình AWS CodeDeploy Application & Deployment Group | 01/07/2026 | 01/07/2026 | <https://000023.awsstudygroup.com/> |
| 5 | - **Lab 23 (Phần 4): Thiết lập AWS CodePipeline** <br>&emsp; + Liên kết Source, Build và Deploy thành luồng CI/CD <br>&emsp; + Khởi chạy Pipeline tự động bằng hành động Commit <br>&emsp; + Kiểm tra luồng dữ liệu truyền qua các Stage | 02/07/2026 | 02/07/2026 | <https://000023.awsstudygroup.com/> |
| 6 | - **Tổng kết tuần** <br>&emsp; + Đánh giá tính liên tục của luồng CI/CD Pipeline <br>&emsp; + Xóa toàn bộ tài nguyên (EC2, Pipeline, Build, CodeCommit, S3) <br>&emsp; + Hoàn thiện báo cáo Worklog | 03/07/2026 | 03/07/2026 | |

### Kết quả đạt được tuần 11:

* **Lab 23: Tự động hóa với AWS Developer Tools**
  * Khởi tạo S3 Bucket và gắn quyền IAM Roles đầy đủ cho chuỗi CI/CD.
    ![S3 & IAM Role](/images/worklog/week11/11.1_s3_iam.png)
  * Khởi tạo thành công kho lưu trữ mã nguồn AWS CodeCommit chứa mã ứng dụng.
    ![AWS CodeCommit](/images/worklog/week11/11.2_codecommit.png)
  * Biên dịch thành công ứng dụng bằng dự án AWS CodeBuild.
    ![AWS CodeBuild](/images/worklog/week11/11.3_codebuild.png)
  * Build Phase Pass hoàn toàn dựa trên cấu hình file `buildspec.yml`.
    ![Buildspec Execution](/images/worklog/week11/11.4_buildspec_logs.png)
  * Khởi chạy EC2 Instances đã cài sẵn môi trường CodeDeploy Agent.
    ![CodeDeploy Agent EC2](/images/worklog/week11/11.5_codedeploy_agent.png)
  * Triển khai mã nguồn thành công thông qua AWS CodeDeploy đến nhóm EC2 Instances.
    ![AWS CodeDeploy](/images/worklog/week11/11.6_codedeploy.png)
  * Thiết lập và chạy toàn vẹn luồng AWS CodePipeline (Source -> Build -> Deploy) hoàn toàn tự động.
    ![AWS CodePipeline](/images/worklog/week11/11.7_codepipeline.png)
