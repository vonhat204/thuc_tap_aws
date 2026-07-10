---
title: "Week 7 Worklog"
date: 2026-04-20
weight: 7
chapter: false
pre: " <b> 1.7. </b> "
---

### Week 7 Objectives:

* Work with Server Migration and modern application deployment.
* Containerize applications using Docker and AWS services.

### Tasks to be implemented this week:
| Day | Task | Start Date | End Date | References |
| --- | --- | --- | --- | --- |
| Mon | - **Lab 14 (Part 1): VM Migration** <br>&emsp; + Prepare VMWare environment <br>&emsp; + Export VM to OVF/VMDK format <br>&emsp; + Upload VM image to S3 | 06/01/2026 | 06/01/2026 | <https://000014.awsstudygroup.com/> |
| Tue | - **Lab 14 (Part 2): Import to AWS** <br>&emsp; + Create IAM Role for VM Import <br>&emsp; + Execute `aws ec2 import-image` <br>&emsp; + Launch EC2 from imported AMI | 06/02/2026 | 06/02/2026 | <https://000014.awsstudygroup.com/> |
| Wed | - **Lab 15 (Part 1): Containerization (Docker)** <br>&emsp; + Write a Dockerfile <br>&emsp; + Build local Docker image <br>&emsp; + Push image to Amazon ECR | 06/03/2026 | 06/03/2026 | <https://000015.awsstudygroup.com/> |
| Thu | - **Lab 15 (Part 2): Environment Config** <br>&emsp; + Launch DB Subnet Group <br>&emsp; + Launch RDS <br>&emsp; + Setup EC2 server (install libraries) | 06/04/2026 | 06/04/2026 | <https://000015.awsstudygroup.com/> |
| Fri | - **Lab 15 (Part 3): Deploy Containers** <br>&emsp; + Deploy application using Docker image <br>&emsp; + Deploy using Docker Compose <br>&emsp; + Application Testing | 06/05/2026 | 06/05/2026 | <https://000015.awsstudygroup.com/> |
| Sat | - **Weekly Summary** <br>&emsp; + Optimize Docker Image <br>&emsp; + Extensive resource cleanup <br>&emsp; + Write Worklog report | 06/06/2026 | 06/06/2026 | |

### Week 7 Achievements:

* **Lab 14: VMWare VM Migration**
  * Successfully exported local VM and uploaded to S3.
    ![S3 Upload](/images/worklog/week7/7.1_vm_s3.png)
  * Imported VM from S3 into AWS EC2 and launched an Instance.
    ![Import VM](/images/worklog/week7/7.2_vm_import.png)
  * Exported an EC2 instance back to a local VMDK/OVA file format.
    ![Export VM](/images/worklog/week7/7.3_vm_export.png)

* **Lab 15: Container Applications with Docker**
  * Packaged source code into a Docker Image and tested it locally.
    ![Docker Local](/images/worklog/week7/7.4_docker_local.png)
  * Authenticated IAM and pushed the Image to Elastic Container Registry (ECR).
    ![ECR Push](/images/worklog/week7/7.5_ecr_push.png)
  * Successfully connected a Container to an external RDS database.
    ![RDS Connect](/images/worklog/week7/7.6_rds_connect.png)
  * Deployed a complete service stack on EC2 using `docker-compose.yml`.
    ![Docker Compose](/images/worklog/week7/7.7_docker_compose.png)
