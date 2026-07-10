---
title: "Week 3 Worklog"
date: 2026-04-20
weight: 3
chapter: false
pre: " <b> 1.3. </b> "
---

### Week 3 Objectives:

* Deploy application servers in real-world environments on both Linux and Windows.
* Set up a Relational Database Service (RDS) and connect it with the application servers.

### Tasks to be implemented this week:
| Day | Task | Start Date | End Date | References |
| --- | --- | --- | --- | --- |
| Mon | - **Lab 4 (Part 1): Launch EC2** <br>&emsp; + Create Linux / Windows VPC <br>&emsp; + Launch Windows Server 2025 <br>&emsp; + Launch Amazon Linux <br>&emsp; + Create and manage EBS snapshots <br>&emsp; + Create custom AMIs | 05/04/2026 | 05/04/2026 | <https://000004.awsstudygroup.com/> |
| Tue | - **Lab 4 (Part 2): Deploy Applications** <br>&emsp; + Install LAMP on Amazon Linux <br>&emsp; + Deploy management application on Linux <br>&emsp; + Install Node.js on Windows <br>&emsp; + Deploy application on Windows | 05/05/2026 | 05/05/2026 | <https://000004.awsstudygroup.com/> |
| Wed | - **Lab 4 (Part 3): Cost Management with IAM** <br>&emsp; + Restrict service usage by region <br>&emsp; + Limit EC2 usage by instance type <br>&emsp; + Manage EBS volume storage types <br>&emsp; + Restrict resource deletion permissions | 05/06/2026 | 05/06/2026 | <https://000004.awsstudygroup.com/> |
| Thu | - **Lab 5: Web & DB Application Deployment** <br>&emsp; + Set up database subnet group <br>&emsp; + Create EC2 & RDS instances <br>&emsp; + Deploy DB-connected application <br>&emsp; + Backup and restore data | 05/07/2026 | 05/07/2026 | <https://000005.awsstudygroup.com/> |
| Fri | - **Weekly Summary** <br>&emsp; + Verify deployed applications <br>&emsp; + Clean up Lab 4 & 5 resources <br>&emsp; + Finalize Worklog | 05/08/2026 | 05/08/2026 | <https://000004.awsstudygroup.com/> |

### Week 3 Achievements:

* **Lab 4 (Part 1): EC2 & EBS/AMI Management**
  * Successfully launched Windows Server 2025 and Amazon Linux instances.
    ![EC2 Instances](/images/worklog/week3/3.1_ec2.png)
  * Created automatic backups (EBS Snapshot) and custom AMIs.
    ![EBS Snapshot & AMI](/images/worklog/week3/3.2_snapshot.png)
  * Successfully restored access to EC2 instances.
    ![Custom AMI](/images/worklog/week3/3.2_ami.png)

* **Lab 4 (Part 2): Web App Deployment**
  * Successfully installed LAMP and Node.js on Amazon Linux EC2.
    ![Linux Web App](/images/worklog/week3/3.3_linux.png)
  * Successfully configured XAMPP and Node.js on Windows EC2.
    ![Windows Web App](/images/worklog/week3/3.3_windows.png)
  * The AWS User Management Application runs stably on both platforms.
    ![Web Apps Running](/images/worklog/week3/3.3_linux.png)

* **Lab 4 & Lab 5: Cost Control & RDS Database**
  * Successfully tested IAM restriction policies (Region limits, EC2 type limits).
    ![IAM Restriction Test](/images/worklog/week3/3.5_iam_policy.png)
  * Successfully configured DB Subnet Group and launched MySQL RDS instance.
    ![RDS Database](/images/worklog/week3/3.4_rds.png)
  * Web application connected successfully to RDS database and performed backup/restore workflow.
    ![RDS Connection](/images/worklog/week3/3.4_rds.png)
