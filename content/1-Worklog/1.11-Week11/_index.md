---
title: "Week 11 Worklog"
date: 2025-10-20
weight: 11
chapter: false
pre: " <b> 1.11. </b> "
---

### Objectives for Week 11:

* Build a fully automated CI/CD (Continuous Integration & Continuous Delivery) pipeline using Native AWS services.
* Explore the AWS Developer Tools suite: CodeCommit, CodeBuild, CodeDeploy, and CodePipeline.

### Tasks to be implemented this week:

| Day | Task | Start Date | End Date | References |
| --- | --- | --- | --- | --- |
| Mon | - **Lab 23 (Part 1): Source Code & Environment** <br>&emsp; + Setup Amazon S3 Bucket for Artifacts <br>&emsp; + Configure IAM Roles for CI/CD services <br>&emsp; + Create AWS CodeCommit Repository <br>&emsp; + Push sample application source code | 06/29/2026 | 06/29/2026 | <https://000023.awsstudygroup.com/> |
| Tue | - **Lab 23 (Part 2): AWS CodeBuild** <br>&emsp; + Initialize AWS CodeBuild project <br>&emsp; + Create `buildspec.yml` file <br>&emsp; + Link CodeBuild with CodeCommit and test build | 06/30/2026 | 06/30/2026 | <https://000023.awsstudygroup.com/> |
| Wed | - **Lab 23 (Part 3): EC2 & CodeDeploy Environment** <br>&emsp; + Launch Target EC2 Server <br>&emsp; + Install CodeDeploy Agent on EC2 <br>&emsp; + Configure CodeDeploy Application & Deployment Group | 07/01/2026 | 07/01/2026 | <https://000023.awsstudygroup.com/> |
| Thu | - **Lab 23 (Part 4): AWS CodePipeline Setup** <br>&emsp; + Connect Source, Build, and Deploy into a pipeline <br>&emsp; + Trigger automated Pipeline via Commit action <br>&emsp; + Verify artifact flow between Stages | 07/02/2026 | 07/02/2026 | <https://000023.awsstudygroup.com/> |
| Fri | - **Weekly Summary** <br>&emsp; + Evaluate end-to-end CI/CD continuity <br>&emsp; + Comprehensive resource cleanup (EC2, Pipeline, Build, CodeCommit, S3) <br>&emsp; + Finalize Worklog report | 07/03/2026 | 07/03/2026 | |

### Achievements in Week 11:

* **Lab 23: AWS Developer Tools CI/CD**
  * Created S3 Bucket and attached full IAM Roles for the CI/CD pipeline.
    ![S3 & IAM Role](/images/worklog/week11/11.1_s3_iam.png)
  * Successfully initialized AWS CodeCommit repository containing the source code.
    ![AWS CodeCommit](/images/worklog/week11/11.2_codecommit.png)
  * Successfully compiled the application using AWS CodeBuild project.
    ![AWS CodeBuild](/images/worklog/week11/11.3_codebuild.png)
  * Build Phase fully passed based on `buildspec.yml` configuration.
    ![Buildspec Execution](/images/worklog/week11/11.4_buildspec_logs.png)
  * Launched target EC2 Instances pre-installed with CodeDeploy Agent environment.
    ![CodeDeploy Agent EC2](/images/worklog/week11/11.5_codedeploy_agent.png)
  * Deployed application successfully via AWS CodeDeploy to target EC2 instances.
    ![AWS CodeDeploy](/images/worklog/week11/11.6_codedeploy.png)
  * Executed a complete, automated AWS CodePipeline (Source -> Build -> Deploy).
    ![AWS CodePipeline](/images/worklog/week11/11.7_codepipeline.png)
