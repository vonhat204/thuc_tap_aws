---
title: "Week 5 Worklog"
date: 2026-04-20
weight: 5
chapter: false
pre: " <b> 1.5. </b> "
---

### Week 5 Objectives:

* Understand AWS Support Plans and how to handle tickets.
* Automate AWS resource management via AWS CLI and implement multi-account structures with AWS Organizations.

### Tasks to be implemented this week:
| Day | Task | Start Date | End Date | References |
| --- | --- | --- | --- | --- |
| Mon | - **Lab 9: AWS Support Plans** <br>&emsp; + Compare Support plans <br>&emsp; + Open mock Support Ticket <br> - **Lab 11: AWS CLI Setup** <br>&emsp; + Install and configure CLI profile <br>&emsp; + List resources via CLI | 05/18/2026 | 05/18/2026 | <https://000009.awsstudygroup.com/> |
| Tue | - **Lab 11 (Continued): CLI Management** <br>&emsp; + Manage S3 Buckets & SNS Topics <br>&emsp; + Configure IAM resources <br>&emsp; + Deploy VPC & Internet Gateway <br>&emsp; + Launch EC2 instance via CLI | 05/19/2026 | 05/19/2026 | <https://000011.awsstudygroup.com/> |
| Wed | - **Lab 12 (Part 1): AWS Organizations** <br>&emsp; + Initialize organization structure <br>&emsp; + Create Organizational Units (OU) <br>&emsp; + Invite member accounts <br>&emsp; + Switch roles to member account | 05/20/2026 | 05/20/2026 | <https://000012.awsstudygroup.com/> |
| Thu | - **Lab 12 (Part 2): Control & Identity** <br>&emsp; + Create Service Control Policies (SCP) <br>&emsp; + Restrict member account actions <br>&emsp; + Set up IAM Identity Center (SSO) | 05/21/2026 | 05/21/2026 | <https://000012.awsstudygroup.com/> |
| Fri | - **Weekly Summary** <br>&emsp; + Troubshoot CLI issues <br>&emsp; + Clean up multi-account resources <br>&emsp; + Write Worklog report | 05/22/2026 | 05/22/2026 | |

### Week 5 Achievements:

* **Lab 9 & Lab 11: AWS Support & CLI Management**
  * Created a mock Support Ticket on the AWS Management Console.
    ![Support Ticket](/images/worklog/week5/5.1_support.png)
  * Configured AWS CLI profile successfully on local workstation.
    ![CLI Profile](/images/worklog/week5/5.2_cli_profile.png)
  * Created S3 Bucket and published SNS Topic directly using CLI commands.
    ![S3 & SNS via CLI](/images/worklog/week5/5.3_cli_s3_sns.png)
  * Deployed VPC network, IGW, and launched an EC2 instance entirely via CLI.
    ![VPC & EC2 via CLI](/images/worklog/week5/5.4_cli_vpc_ec2.png)

* **Lab 12: AWS Organizations & Security Control**
  * Created AWS Organization structure and Organizational Unit (OU).
    ![Organizations & OU](/images/worklog/week5/5.5_org_ou.png)
  * Configured cross-account Switch Role capability for member access.
    ![Switch Account](/images/worklog/week5/5.6_org_switch.png)
  * Created and attached Service Control Policy (SCP) to restrict target resources.
    ![SCP Config](/images/worklog/week5/5.7_org_scp.png)
  * Implemented unified Single Sign-On using IAM Identity Center.
    ![IAM Identity Center SSO](/images/worklog/week5/5.8_sso.png)
