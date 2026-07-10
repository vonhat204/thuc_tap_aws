Write-Output "Ensuring Default VPC exists..."
$defaultVpc = aws ec2 create-default-vpc --query "Vpc.VpcId" --output text 2>$null
if (-not $defaultVpc) {
    Write-Output "Default VPC already exists or could not be created."
}
$vpcId = aws ec2 describe-vpcs --filters "Name=isDefault,Values=true" --query "Vpcs[0].VpcId" --output text
$subnetId = aws ec2 describe-subnets --filters "Name=vpc-id,Values=$vpcId" --query "Subnets[0].SubnetId" --output text
$sgId = aws ec2 describe-security-groups --filters "Name=vpc-id,Values=$vpcId" "Name=group-name,Values=default" --query "SecurityGroups[0].GroupId" --output text

$amiId = aws ssm get-parameters --names /aws/service/ami-amazon-linux-latest/al2023-ami-kernel-6.1-x86_64 --query "Parameters[0].Value" --output text
$instanceProfile = aws cloudformation describe-stacks --stack-name fcj-week11 --query "Stacks[0].Outputs[?OutputKey=='InstanceProfileName'].OutputValue" --output text

$userData = '#!/bin/bash
yum update -y
yum install -y ruby wget
cd /home/ec2-user
wget https://aws-codedeploy-ap-southeast-2.s3.ap-southeast-2.amazonaws.com/latest/install
chmod +x ./install
./install auto
systemctl start codedeploy-agent
systemctl enable codedeploy-agent
'
$userDataB64 = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($userData))

Write-Output "Launching EC2 for CodeDeploy..."
$instId = aws ec2 run-instances --image-id $amiId --count 1 --instance-type t2.micro --subnet-id $subnetId --security-group-ids $sgId --iam-instance-profile Name=$instanceProfile --user-data $userDataB64 --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=CodeDeployServer},{Key=Environment,Value=production}]" --query "Instances[0].InstanceId" --output text

Write-Output "Creating CodePipeline..."
$pipelineRole = aws cloudformation describe-stacks --stack-name fcj-week11 --query "Stacks[0].Outputs[?OutputKey=='PipelineRoleArn'].OutputValue" --output text
$bucketName = aws cloudformation describe-stacks --stack-name fcj-week11 --query "Stacks[0].Outputs[?OutputKey=='BucketName'].OutputValue" --output text
$repoName = aws cloudformation describe-stacks --stack-name fcj-week11 --query "Stacks[0].Outputs[?OutputKey=='RepoName'].OutputValue" --output text

$pipelineJson = @"
{
  "pipeline": {
    "name": "fcj-webapp-pipeline",
    "roleArn": "$pipelineRole",
    "artifactStore": {
      "type": "S3",
      "location": "$bucketName"
    },
    "stages": [
      {
        "name": "Source",
        "actions": [
          {
            "name": "SourceAction",
            "actionTypeId": {
              "category": "Source",
              "owner": "AWS",
              "provider": "CodeCommit",
              "version": "1"
            },
            "runOrder": 1,
            "configuration": {
              "BranchName": "main",
              "RepositoryName": "$repoName"
            },
            "outputArtifacts": [
              {
                "name": "SourceArtifact"
              }
            ],
            "inputArtifacts": []
          }
        ]
      },
      {
        "name": "Build",
        "actions": [
          {
            "name": "BuildAction",
            "actionTypeId": {
              "category": "Build",
              "owner": "AWS",
              "provider": "CodeBuild",
              "version": "1"
            },
            "runOrder": 1,
            "configuration": {
              "ProjectName": "fcj-webapp"
            },
            "outputArtifacts": [
              {
                "name": "BuildArtifact"
              }
            ],
            "inputArtifacts": [
              {
                "name": "SourceArtifact"
              }
            ]
          }
        ]
      },
      {
        "name": "Deploy",
        "actions": [
          {
            "name": "DeployAction",
            "actionTypeId": {
              "category": "Deploy",
              "owner": "AWS",
              "provider": "CodeDeploy",
              "version": "1"
            },
            "runOrder": 1,
            "configuration": {
              "ApplicationName": "fcj-webapp",
              "DeploymentGroupName": "fcj-webapp-dg"
            },
            "outputArtifacts": [],
            "inputArtifacts": [
              {
                "name": "BuildArtifact"
              }
            ]
          }
        ]
      }
    ]
  }
}
"@
Set-Content -Path scratch/pipeline.json -Value $pipelineJson -Encoding Ascii
aws codepipeline create-pipeline --cli-input-json file://scratch/pipeline.json | Out-Null

Write-Output "Week 11 Part 2 Complete!"
