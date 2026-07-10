---
title: "Week 9 Worklog"
date: 2025-10-06
weight: 9
chapter: false
pre: " <b> 1.9. </b> "
---

### Objectives for Week 9:

* Evaluate and manage security scores across the AWS account using AWS Security Hub.
* Establish peer-to-peer network connections between independent VPCs (VPC Peering) and configure cross-network routing.

### Tasks to be implemented this week:

| Day | Task | Start Date | End Date | References |
| --- | --- | --- | --- | --- |
| Mon | - **Lab 18: AWS Security Hub** <br>&emsp; + Learn about security standards <br>&emsp; + Enable AWS Security Hub <br>&emsp; + Review AWS Foundational Security Best Practices <br>&emsp; + Evaluate CIS AWS Foundations Benchmark <br>&emsp; + Analyze Security Score | 06/15/2026 | 06/15/2026 | <https://000018.awsstudygroup.com/> |
| Tue | - **Lab 19 (Part 1): VPC Infrastructure** <br>&emsp; + Provision infrastructure (CloudFormation Template) <br>&emsp; + Set up Subnets and Route Tables <br>&emsp; + Launch EC2 servers (Instance A & B) <br>&emsp; + Update Network ACL for subnets <br>&emsp; + Configure Security Group for EC2 | 06/16/2026 | 06/16/2026 | <https://000019.awsstudygroup.com/> |
| Wed | - **Lab 19 (Part 2): VPC Peering Connection** <br>&emsp; + Initiate VPC Peering Connection from source VPC <br>&emsp; + Accept Peering connection at target VPC <br>&emsp; + Configure routing via Peering (VPC A Route Table) <br>&emsp; + Configure routing via Peering (VPC B Route Table) | 06/17/2026 | 06/17/2026 | <https://000019.awsstudygroup.com/> |
| Thu | - **Lab 19 (Part 3): Cross-Peer DNS & Testing** <br>&emsp; + Enable Cross-Peer DNS Resolution <br>&emsp; + Test cross-VPC internal domain name resolution <br>&emsp; + SSH access to EC2 instances <br>&emsp; + Ping test ICMP communication between instances via Private IP | 06/18/2026 | 06/18/2026 | <https://000019.awsstudygroup.com/> |
| Fri | - **Weekly Summary** <br>&emsp; + Re-evaluate overall security posture <br>&emsp; + Comprehensive resource cleanup (VPC, Peering, EC2) <br>&emsp; + Disable Security Hub to prevent charges <br>&emsp; + Write Worklog report | 06/19/2026 | 06/19/2026 | |

### Achievements in Week 9:

* **Lab 18: AWS Security Hub**
  * Successfully enabled Security Hub in "Enabled" status.
    ![Enable Security Hub](/images/worklog/week9/9.1_security_hub_enable.png)
  * Evaluated Security Score based on CIS and AWS Foundational standards.
    ![Security Score](/images/worklog/week9/9.2_security_score.png)
  * Analyzed detailed security standards (Passed/Failed checks) of CIS Benchmark.
    ![CIS Benchmark Details](/images/worklog/week9/9.3_cis_benchmark.png)

* **Lab 19: VPC Peering**
  * Provisioned VPC and EC2 infrastructure architecture across 2 different VPCs.
    ![VPC Architecture](/images/worklog/week9/9.4_vpc_architecture.png)
  * Established VPC Peering connection in "Active" state.
    ![VPC Peering Connection](/images/worklog/week9/9.5_vpc_peering.png)
  * Configured Route Tables for routing via Peering Connection (target pcx-...).
    ![Route Tables](/images/worklog/week9/9.6_route_tables.png)
  * Enabled cross DNS and successfully verified network by Pinging between Private IPs.
    ![Ping Test](/images/worklog/week9/9.7_ping_test.png)
