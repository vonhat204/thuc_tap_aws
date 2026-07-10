---
title: "Week 8 Worklog"
date: 2026-04-20
weight: 8
chapter: false
pre: " <b> 1.8. </b> "
---

### Week 8 Objectives:

* Deploy microservices on an ECS cluster integrated with a Load Balancer.
* Build an automated CI/CD pipeline for source code deployment.

### Tasks to be implemented this week:
| Day | Task | Start Date | End Date | References |
| --- | --- | --- | --- | --- |
| Mon | - **Lab 16 (Part 1): ECS Cluster & Cloud Map** <br>&emsp; + Register namespace in Cloud Map <br>&emsp; + Create ECS Cluster <br>&emsp; + Create Task Definition <br>&emsp; + Push images to ECR | 06/08/2026 | 06/08/2026 | <https://000016.awsstudygroup.com/> |
| Tue | - **Lab 16 (Part 2): Load Balancer & ECS Service** <br>&emsp; + Configure Application Load Balancer <br>&emsp; + Create ECS Service <br>&emsp; + Blue/Green deployment for Backend <br>&emsp; + Rolling deployment for Frontend | 06/09/2026 | 06/09/2026 | <https://000016.awsstudygroup.com/> |
| Wed | - **Lab 17 (Part 1): CI/CD with GitLab/GitHub** <br>&emsp; + Install and register GitLab Runner <br>&emsp; + Run GitLab CI/CD pipeline <br>&emsp; + Create access keys & push code to GitHub <br>&emsp; + Deploy GitHub Actions | 06/10/2026 | 06/10/2026 | <https://000017.awsstudygroup.com/> |
| Thu | - **Lab 17 (Part 2): AWS CodeBuild & Logging** <br>&emsp; + Create CodeBuild for Frontend / Backend <br>&emsp; + Setup Container Insights (CloudWatch) <br>&emsp; + Create Firelens log router <br>&emsp; + Update ECS service for log testing | 06/11/2026 | 06/11/2026 | <https://000017.awsstudygroup.com/> |
| Fri | - **Weekly Summary** <br>&emsp; + Verify CI/CD Pipeline results <br>&emsp; + Comprehensive garbage collection <br>&emsp; + Write Worklog report | 06/12/2026 | 06/12/2026 | |

### Week 8 Achievements:

* **Lab 16: ECS & Load Balancer**
  * Initialized an ECS Cluster and registered a Namespace in AWS Cloud Map.
    ![ECS Cluster](/images/worklog/week8/8.1_ecs_cluster.png)
  * Created Task Definitions and attached an Application Load Balancer to an ECS Service.
    ![ECS Task Definition](/images/worklog/week8/8.2_ecs_taskdef.png)
  * Safely deployed Backend utilizing Blue/Green Deployment strategy.
    ![Blue/Green Deployment](/images/worklog/week8/8.3_ecs_bluegreen.png)
  * Updated Frontend patches using Rolling Update strategy.
    ![Rolling Update](/images/worklog/week8/8.4_ecs_rolling.png)

* **Lab 17: CI/CD Pipeline & Monitoring**
  * Successfully registered GitLab Runner and executed an automated Image build pipeline.
    ![GitLab Runner & Targets](/images/worklog/week8/8.5_gitlab_runner.png)
  * Integrated GitHub Actions and AWS CodeBuild to implement Continuous Deployment.
    ![CodeBuild](/images/worklog/week8/8.6_codebuild.png)
  * Configured AWS Firelens to route container logs directly to S3.
    ![Cloud Map DNS](/images/worklog/week8/8.7_firelens.png)
  * Monitored individual Task CPU/Memory resources through CloudWatch Container Insights.
    ![Container Insights](/images/worklog/week8/8.8_container_insights.png)
