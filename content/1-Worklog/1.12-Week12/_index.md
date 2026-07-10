---
title: "Week 12 Worklog"
date: 2025-10-27
weight: 12
chapter: false
pre: " <b> 1.12. </b> "
---

### Objectives for Week 12:

* Deploy Hybrid Storage solutions with AWS Storage Gateway.
* Secure Web applications using AWS WAF firewall against common vulnerabilities.
* Manage AWS resources efficiently using Tags and Resource Groups.

### Tasks to be implemented this week:

| Day | Task | Start Date | End Date | References |
| --- | --- | --- | --- | --- |
| Mon | - **Lab 24: AWS Storage Gateway** <br>&emsp; + Launch Storage Gateway VM on EC2 <br>&emsp; + Configure S3 File Shares <br>&emsp; + Mount File Share to local machine <br>&emsp; + Upload file to sync data to S3 | 07/06/2026 | 07/06/2026 | <https://000024.awsstudygroup.com/> |
| Tue | - **Lab 26: AWS WAF Security** <br>&emsp; + Deploy sample Web App and ALB <br>&emsp; + Configure Web ACLs and Managed Rules <br>&emsp; + Write Custom Rules to block specific IPs <br>&emsp; + Enable Traffic Logging | 07/07/2026 | 07/07/2026 | <https://000026.awsstudygroup.com/> |
| Wed | - **Lab 27: Resource Groups & Tags** <br>&emsp; + Create EC2 Instance with Tags <br>&emsp; + Manage Tags on AWS Resources <br>&emsp; + Filter resources by Tag <br>&emsp; + Create Resource Group | 07/08/2026 | 07/08/2026 | <https://000027.awsstudygroup.com/> |
| Thu | - **Final Summary & Cleanup** <br>&emsp; + Review Internship Worklogs <br>&emsp; + Complete deletion of Storage Gateway, WAF, Resource Groups <br>&emsp; + Internship Wrap-up | 07/09/2026 | 07/09/2026 | |

### Achievements in Week 12:

* **Lab 24: AWS Storage Gateway**
  * Successfully launched File Gateway virtual machine instance on EC2.
    ![File Gateway VM](/images/worklog/week12/12.1_file_gateway_vm.png)
  * Successfully initialized File Gateway VM and mapped it as a local network drive on Windows.
    ![Storage Gateway Mount](/images/worklog/week12/12.2_storage_gateway.png)
  * Uploaded files to the local Mount point were securely synced to the S3 Bucket.
    ![S3 Sync](/images/worklog/week12/12.3_s3_sync.png)

* **Lab 26: AWS WAF**
  * Successfully deployed Web ACLs integrated with Application Load Balancer to protect the web app.
    ![WAF Web ACL](/images/worklog/week12/12.4_waf_acl.png)
  * Configured Custom Rules & Managed Rules against common vulnerabilities (SQLi, XSS).
    ![WAF Rules](/images/worklog/week12/12.5_waf_rules.png)
  * WAF successfully blocked unauthorized access and displayed Traffic Metrics.
    ![WAF Blocked Traffic](/images/worklog/week12/12.6_waf_blocked.png)

* **Lab 27: Resource Groups & Tags**
  * Successfully created an EC2 Instance with basic Tags (Environment, Project).
    ![EC2 Tags](/images/worklog/week12/12.7_ec2_tags.png)
  * Easily managed and filtered resources using Tag Editor.
    ![Tag Editor](/images/worklog/week12/12.8_tag_editor.png)
  * Created an AWS Resource Group to automatically group resources by Tag.
    ![Resource Group](/images/worklog/week12/12.9_resource_group.png)
