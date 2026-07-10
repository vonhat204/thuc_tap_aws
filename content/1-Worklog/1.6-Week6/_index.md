---
title: "Week 6 Worklog"
date: 2026-04-20
weight: 6
chapter: false
pre: " <b> 1.6. </b> "
---

### Week 6 Objectives:

* Set up AWS Directory Service (Microsoft Active Directory) and configure DNS routing using Route 53.
* Design and implement database/storage backup and recovery strategies using S3 and AWS Backup.

### Tasks to be implemented this week:
| Day | Task | Start Date | End Date | References |
| --- | --- | --- | --- | --- |
| Mon | - **Lab 10 (Part 1): Infrastructure Deployment** <br>&emsp; + Deploy CloudFormation template <br>&emsp; + Configure security groups and keys <br>&emsp; + Connect to Remote Desktop Gateway (RDGW) | 05/25/2026 | 05/25/2026 | <https://000010.awsstudygroup.com/> |
| Tue | - **Lab 10 (Part 2): Microsoft AD & Route 53** <br>&emsp; + Deploy Microsoft Active Directory on AWS <br>&emsp; + Configure Inbound and Outbound Resolver Endpoints <br>&emsp; + Map hybrid DNS routing rules | 05/26/2026 | 05/26/2026 | <https://000010.awsstudygroup.com/> |
| Wed | - **Lab 13 (Part 1): Backup Infrastructure** <br>&emsp; + Create dedicated S3 Backup Buckets <br>&emsp; + Set up network infrastructure for backup traffic | 05/27/2026 | 05/27/2026 | <https://000013.awsstudygroup.com/> |
| Thu | - **Lab 13 (Part 2): Disaster Recovery Plan** <br>&emsp; + Design AWS Backup Plan <br>&emsp; + Configure notifications and alarms <br>&emsp; + Test data restore operations | 05/28/2026 | 05/28/2026 | <https://000013.awsstudygroup.com/> |
| Fri | - **Weekly Summary** <br>&emsp; + Validate DNS resolution paths <br>&emsp; + Clean up Lab 10 & 13 resources <br>&emsp; + Write Worklog report | 05/29/2026 | 05/29/2026 | <https://000010.awsstudygroup.com/> |

### Week 6 Achievements:

* **Lab 10: Microsoft AD & Route 53 Resolver**
  * Automated base infrastructure deployment using a CloudFormation template.
    ![CloudFormation Stacks](/images/worklog/week6/6.1_cfn.png)
  * Configured secure connectivity to Remote Desktop Gateway (RDGW).
    ![RDGW Connection](/images/worklog/week6/6.2_rdgw.png)
  * Provisioned active directory on AWS Directory Service.
    ![Active Directory](/images/worklog/week6/6.3_ad.png)
  * Created Inbound and Outbound resolver endpoints to route DNS requests.
    ![Route 53 Resolver Endpoints](/images/worklog/week6/6.4_r53_endpoints.png)

* **Lab 13: AWS Backup & Recovery**
  * Created dedicated S3 buckets to serve as backup destinations.
    ![S3 Backup Bucket](/images/worklog/week6/6.5_s3_backup.png)
  * Built and activated a Backup Plan with automated lifecycle rules.
    ![Backup Plan](/images/worklog/week6/6.6_backup_plan.png)
  * Simulated data loss and successfully executed a restore job.
    ![Restore Job](/images/worklog/week6/6.7_backup_restore.png)
