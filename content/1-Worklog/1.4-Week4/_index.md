---
title: "Week 4 Worklog"
date: 2026-04-20
weight: 4
chapter: false
pre: " <b> 1.4. </b> "
---

### Week 4 Objectives:

* Deploy Auto Scaling and Load Balancing to achieve high availability and scalability.
* Set up budget management on AWS and monitor application metrics via CloudWatch.

### Tasks to be implemented this week:
| Day | Task | Start Date | End Date | References |
| --- | --- | --- | --- | --- |
| Mon | - **Lab 6 (Part 1): Load Balancer** <br>&emsp; + Create target group <br>&emsp; + Configure Application Load Balancer <br>&emsp; + Map routing rules | 05/11/2026 | 05/11/2026 | <https://000006.awsstudygroup.com/> |
| Tue | - **Lab 6 (Part 2): Auto Scaling** <br>&emsp; + Create Launch Template <br>&emsp; + Create Auto Scaling Group (ASG) <br>&emsp; + Configure scaling policies | 05/12/2026 | 05/12/2026 | <https://000006.awsstudygroup.com/> |
| Wed | - **Lab 7: Budget Management** <br>&emsp; + Set up cost budgets <br>&emsp; + Configure usage budgets <br>&emsp; + Manage budget alerts | 05/13/2026 | 05/13/2026 | <https://000007.awsstudygroup.com/> |
| Thu | - **Lab 8 (Part 1): CloudWatch Metrics** <br>&emsp; + Set up log metric filters <br>&emsp; + Create CloudWatch Alarms <br>&emsp; + Monitor system metrics | 05/14/2026 | 05/14/2026 | <https://000008.awsstudygroup.com/> |
| Fri | - **Lab 8 (Part 2): Dashboard & Summary** <br>&emsp; + Design custom CloudWatch Dashboard <br>&emsp; + Verify load balancing and auto scaling <br>&emsp; + Resource cleanup | 05/15/2026 | 05/15/2026 | <https://000008.awsstudygroup.com/> |

### Week 4 Achievements:

* **Lab 6: Load Balancing & Auto Scaling**
  * Successfully created Launch Template and Target Group for web servers.
    ![Launch Template & Target Group](/images/worklog/week4/4.1_alb_tg.png)
  * Configured Application Load Balancer to distribute traffic correctly.
    ![ALB Status](/images/worklog/week4/4.2_alb.png)
  * Verified manual and scheduled scaling behaviors within ASG.
    ![ASG Status](/images/worklog/week4/4.3_asg.png)
  * Verified dynamic scaling based on CPU utilization metrics.
    ![ASG Dynamic Scaling](/images/worklog/week4/4.4_asg_scaling.png)

* **Lab 7: AWS Budgets**
  * Successfully configured Cost and Usage Budgets to track expenses.
    ![AWS Budgets](/images/worklog/week4/4.5_budget.png)
  * Implemented Savings Plans and RI alerts to optimize AWS spending.
    ![Savings Plans & RI budgets](/images/worklog/week4/4.5_budget.png)

* **Lab 8: CloudWatch Monitoring**
  * Configured Log Metric Filters to monitor specific application patterns.
    ![Metric Filters](/images/worklog/week4/4.6_cw_metrics.png)
  * Created CloudWatch Alarms to trigger alerts on high CPU thresholds.
    ![CloudWatch Alarms](/images/worklog/week4/4.7_cw_alarm.png)
  * Structured system metrics into a comprehensive CloudWatch Dashboard.
    ![CloudWatch Dashboard](/images/worklog/week4/4.8_cw_dashboard.png)
