import docx

doc = docx.Document('1-Phieu-Theo-doi-Tien-do-TTTN (7).docx')
table = doc.tables[1]

# Cập nhật ngày cho tuần 12
table.rows[12].cells[1].text = '06/07/2026 – 12/07/2026'

new_contents = [
    """- Tổng hợp thời gian rảnh của các thành viên trong nhóm và thiết kế Worklog cho các thành viên.
- Tìm hiểu tổng quan về AWS và kiến trúc cơ bản.
- Xem và tìm hiểu các loại dịch vụ triển khai máy chủ ảo EC2.""",

    """- Tìm hiểu và thực hành triển khai kiến trúc mạng VPC hoàn chỉnh (Subnet, Route Table, IGW, NAT Gateway, Security Group).
- Triển khai EC2 trên Public/Private Subnet; cấu hình quản trị an toàn qua SSM và giám sát hệ thống bằng CloudWatch.
- Thiết lập kết nối AWS Site-to-Site VPN cho mạng chi nhánh.""",

    """- Tìm hiểu và thực hành khởi tạo, cấu hình, quản lý Amazon EC2 Instance (Linux và Windows Server 2025).
- Thực hiện sao lưu dữ liệu với EBS Snapshot, tạo Custom AMI và cấu hình Sysprep cho Windows.
- Triển khai ứng dụng Node.js (AWS User Management) trên môi trường LAMP Stack (Apache, MariaDB, PHP).""",

    """- Khởi tạo, cấu hình Amazon RDS (MySQL/MariaDB); thiết lập bảo mật qua Security Groups và DB Subnet Group.
- Kết nối và cấu hình ứng dụng Node.js để sử dụng Amazon RDS làm cơ sở dữ liệu chính.
- Thực hành quản trị CSDL: sao lưu (Snapshot), khôi phục (Restore) và tìm hiểu các tính năng cao cấp như Multi-AZ, Read Replicas.""",

    """- Triển khai hệ thống mở rộng tự động với Amazon EC2 Auto Scaling; thiết lập Launch Template, cấu hình Application Load Balancer (ALB) và Target Group.
- Tạo Auto Scaling Group tích hợp ALB; kiểm thử các giải pháp scaling: Manual, Scheduled, Dynamic và Predictive Scaling.
- Thực hành quản lý chi phí AWS với AWS Budgets; thiết lập các ngân sách cảnh báo (Cost, Usage, RI, Savings Plans).""",

    """- Giám sát hệ thống với Amazon CloudWatch: theo dõi Metrics, phân tích log bằng CloudWatch Logs Insights, tạo Metric Filter, thiết lập Alarms và Dashboard tổng quan.
- Tìm hiểu các gói hỗ trợ của AWS; thực hành khởi tạo Support Case và quản lý yêu cầu hỗ trợ.
- Triển khai hạ tầng Hybrid DNS tích hợp on-premises với AWS thông qua Microsoft Active Directory và Route 53 Resolver.""",

    """- Cài đặt, tương tác và quản lý các tài nguyên dịch vụ AWS (S3, SNS, IAM, VPC, EC2) thông qua giao diện dòng lệnh AWS CLI.
- Tìm hiểu cấu trúc quản lý đa tài khoản bằng AWS Organizations và IAM Identity Center (Single Sign-On).
- Triển khai giải pháp sao lưu, khôi phục dữ liệu tập trung với AWS Backup; cấu hình thông báo tự động và khôi phục thử nghiệm (Test Restore).""",

    """- Thực hành dịch chuyển máy chủ bằng VM Import/Export: xuất máy ảo từ On-premise, tải lên Amazon S3, import thành Custom AMI và khởi chạy EC2 Instance.
- Đóng gói ứng dụng bằng Docker; xây dựng Dockerfile, cài đặt và kiểm thử ứng dụng chạy trong container trên máy chủ EC2.
- Quản lý đa container với Docker Compose trên EC2; kết nối container với Amazon RDS.
- Đẩy (push) Docker Images lên Amazon ECR và Docker Hub để quản lý và deploy.""",

    """- Triển khai ứng dụng (Frontend/Backend) lên Amazon ECS (Fargate) kết hợp Application Load Balancer (ALB).
- Tự động hóa quy trình CI/CD qua GitLab CI/CD, GitHub Actions và AWS CodeBuild.
- Cấu hình giám sát Container Insights (CloudWatch) và định tuyến log qua AWS Firelens về S3.
- Đánh giá và chấm điểm an toàn hệ thống thông qua AWS Security Hub (tiêu chuẩn FSBP/CIS).""",

    """- Thiết lập VPC Peering kết nối 2 VPC và cấu hình Network ACL (NACL) dạng stateless cấp độ subnet để kiểm soát lưu lượng.
- Triển khai AWS Transit Gateway kết nối chéo 3 VPC theo mô hình Hub-and-Spoke.
- Tự động hóa bật/tắt máy chủ EC2 tối ưu chi phí bằng AWS Lambda và Amazon EventBridge.
- Tích hợp gửi thông báo trạng thái hoạt động của máy chủ về kênh chat Slack qua Incoming Webhooks.""",

    """- Cấu hình AWS File Storage Gateway kết nối hệ thống lưu trữ On-premises đồng bộ lên Amazon S3.
- Triển khai AWS WAF với Web ACLs và Custom rules để bảo vệ ứng dụng web khỏi các cuộc tấn công.
- Thực hành quản lý, phân loại tài nguyên AWS hiệu quả bằng Tags và Resource Groups.""",

    """- Tổng hợp toàn bộ dữ liệu, kiến thức và kết quả thực tập vào website báo cáo (Static Site Generator) bằng framework Hugo.
- Cấu hình đa ngôn ngữ (Tiếng Anh/Tiếng Việt) cho website, tùy chỉnh giao diện (hugo-theme-learn), sửa lỗi định tuyến đường dẫn liên kết (URL routing).
- Viết mã xử lý hình ảnh (Markdown Render Hook) để website hiển thị đúng ảnh ở mọi môi trường.
- Thiết lập quy trình CI/CD thông qua GitHub Actions để tự động biên dịch và triển khai (deploy) báo cáo lên GitHub Pages hoàn chỉnh."""
]

for week_index in range(12):
    row_index = week_index + 1
    table.rows[row_index].cells[2].text = new_contents[week_index]

doc.save('1-Phieu-Theo-doi-Tien-do-TTTN (7)_updated.docx')
