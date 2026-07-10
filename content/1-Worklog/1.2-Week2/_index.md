---
title: "Week 2 Worklog"
date: 2026-04-20
weight: 2
chapter: false
pre: " <b> 1.2. </b> "
---

### Week 2 Objectives:

* Learn and practice Identity and Access Management (IAM).
* Build basic network infrastructure with VPC and establish a Virtual Private Network (VPN) connection.

### Tasks to be implemented this week:
| Day | Task | Start Date | End Date | References |
| --- | --- | --- | --- | --- |
| Mon | - **Lab 2: Identity and Access Management (IAM)** <br>&emsp; + IAM Groups and IAM Users <br>&emsp; + IAM Policies and IAM Roles <br>&emsp; + Create administrator group <br>&emsp; + Create admin & operator users <br>&emsp; + Switch Role | 04/27/2026 | 04/27/2026 | <https://000002.awsstudygroup.com/> |
| Tue | - **Lab 3 (Part 1): Build VPC Infrastructure** <br>&emsp; + Create Subnets <br>&emsp; + Configure Route Table <br>&emsp; + Internet Gateway <br>&emsp; + NAT Gateway <br>&emsp; + Security Group | 04/28/2026 | 04/28/2026 | <https://000003.awsstudygroup.com/> |
| Wed | - **Lab 3 (Part 2): Deploy EC2** <br>&emsp; + Create EC2 instances <br>&emsp; + Test network connectivity <br>&emsp; + Use Systems Manager <br>&emsp; + CloudWatch monitoring and alarms | 04/29/2026 | 04/29/2026 | <https://000003.awsstudygroup.com/> |
| Thu | - **Lab 3 (Part 3): VPN Connection** <br>&emsp; + Setup Site-to-Site VPN <br>&emsp; + Configure Customer Gateway <br>&emsp; + Use Strongswan with Transit Gateway | 04/30/2026 | 04/30/2026 | <https://000003.awsstudygroup.com/> |
| Fri | - **Weekly Summary** <br>&emsp; + Troubleshoot common errors <br>&emsp; + Clean up Lab 2 & 3 resources <br>&emsp; + Write Worklog report | 05/01/2026 | 05/01/2026 | <https://000002.awsstudygroup.com/> |

### Week 2 Achievements:

* **Lab 2: Identity and Access Management (IAM)**
  * Successfully created Administrator Group and assigned Policies.
    ![IAM User Group](/images/worklog/week2/2.1.png)
  * Successfully created Admin & Operator Users.
    ![IAM Users](/images/worklog/week2/2.2.png)
  * Successfully performed Switch Role.
    ![Switch Role](/images/worklog/week2/2.3.png)

* **Lab 3 (Part 1): Build VPC Infrastructure**
  * Configured Subnets and Route Table.
    ![VPC Subnets & Route Table](/images/worklog/week2/2.4.png)
  * Successfully created and attached Internet Gateway & NAT Gateway.
    ![Internet Gateway & NAT Gateway](/images/worklog/week2/2.4.png)
  * Set up Security Group rules for web servers.
    ![Security Group](/images/worklog/week2/2.5.png)

* **Lab 3 (Part 2): Deploy EC2**
  * Successfully launched EC2 instances in Public and Private subnets.
    ![EC2 Instances](/images/worklog/week2/2.6.png)
  * Verified connectivity using AWS Systems Manager (SSM).
    > *Practice screenshot:*
  * Created CloudWatch Alarms for CPU utilization.
    ![CloudWatch Alarm](/images/worklog/week2/2.7.png)

* **Lab 3 (Part 3): VPN Connection**
  * Configured Site-to-Site VPN and Customer Gateway.
    ![VPN Connection](/images/worklog/week2/2.8.png)
  * Successfully connected from on-premises (Strongswan) to AWS VPC.
    > *Practice screenshot:*

* **Self-Evaluation & Lessons Learned:**
  * ...
