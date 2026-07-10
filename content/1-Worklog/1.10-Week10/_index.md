---
title: "Week 10 Worklog"
date: 2025-10-13
weight: 10
chapter: false
pre: " <b> 1.10. </b> "
---

### Objectives for Week 10:

* Build a hub-and-spoke network architecture connecting multiple VPCs centrally using AWS Transit Gateway.
* Write an AWS Lambda function and integrate with Webhooks to send automated EC2 status notifications to Slack.

### Tasks to be implemented this week:

| Day | Task | Start Date | End Date | References |
| --- | --- | --- | --- | --- |
| Mon | - **Lab 20 (Part 1): Transit Gateway Infrastructure** <br>&emsp; + Provision 3 independent VPCs (A, B, C) <br>&emsp; + Launch EC2 instances across networks <br>&emsp; + Create AWS Transit Gateway (TGW) | 06/22/2026 | 06/22/2026 | <https://000020.awsstudygroup.com/> |
| Tue | - **Lab 20 (Part 2): TGW Routing** <br>&emsp; + Create TGW Attachments to connect VPCs <br>&emsp; + Configure TGW Route Tables <br>&emsp; + Update VPC Route Tables <br>&emsp; + Test inter-network communication via TGW | 06/23/2026 | 06/23/2026 | <https://000020.awsstudygroup.com/> |
| Wed | - **Lab 22 (Part 1): AWS Lambda & EventBridge** <br>&emsp; + Configure IAM Role for Lambda <br>&emsp; + Author AWS Lambda function in Python/Node.js <br>&emsp; + Create EventBridge rule for EC2 state changes | 06/24/2026 | 06/24/2026 | <https://000022.awsstudygroup.com/> |
| Thu | - **Lab 22 (Part 2): Slack Webhook Integration** <br>&emsp; + Set up Slack channel and Incoming Webhooks <br>&emsp; + Integrate Webhook URL into Lambda variables <br>&emsp; + Start/Stop EC2 to trigger alerts | 06/25/2026 | 06/25/2026 | <https://000022.awsstudygroup.com/> |
| Fri | - **Weekly Summary** <br>&emsp; + Evaluate TGW Hub-and-Spoke model <br>&emsp; + Comprehensive resource cleanup (TGW, EC2, VPC, Lambda) <br>&emsp; + Write Worklog report | 06/26/2026 | 06/26/2026 | |

### Achievements in Week 10:

* **Lab 20: AWS Transit Gateway**
  * Fully deployed 3 isolated VPCs containing EC2 Instances.
    ![VPCs and EC2s](/images/worklog/week10/10.1_vpcs_ec2.png)
  * Successfully initialized TGW Resource in Available status.
    ![Transit Gateway](/images/worklog/week10/10.2_transit_gateway.png)
  * Created TGW Attachments linking 3 VPCs to the central Gateway.
    ![TGW Attachments](/images/worklog/week10/10.3_tgw_attachments.png)
  * Established TGW Route Tables routing and successfully pinged EC2 instances.
    ![TGW Routing & Ping Test](/images/worklog/week10/10.4_tgw_ping.png)

* **Lab 22: Serverless Notification (Lambda & Slack)**
  * Accurately configured IAM Role granting execution permissions for Lambda.
    ![IAM Role for Lambda](/images/worklog/week10/10.5_iam_role.png)
  * Successfully deployed AWS Lambda function combined with EventBridge rules.
    ![AWS Lambda](/images/worklog/week10/10.6_lambda_function.png)
  * Deployed Lambda code (Python/Node.js) and integrated Webhook URL.
    ![Lambda Code & Webhook](/images/worklog/week10/10.7_lambda_code.png)
  * Automatically received EC2 status change alerts directly in Slack channel.
    ![Slack Notification](/images/worklog/week10/10.8_slack_alert.png)
