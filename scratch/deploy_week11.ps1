Write-Output "Deploying Week 11 CloudFormation..."
aws cloudformation deploy --template-file scratch/week11.yaml --stack-name fcj-week11 --capabilities CAPABILITY_IAM

Write-Output "Getting Stack Outputs..."
$bucketName = aws cloudformation describe-stacks --stack-name fcj-week11 --query "Stacks[0].Outputs[?OutputKey=='BucketName'].OutputValue" --output text
$repoName = aws cloudformation describe-stacks --stack-name fcj-week11 --query "Stacks[0].Outputs[?OutputKey=='RepoName'].OutputValue" --output text
$pipelineRole = aws cloudformation describe-stacks --stack-name fcj-week11 --query "Stacks[0].Outputs[?OutputKey=='PipelineRoleArn'].OutputValue" --output text
$instanceProfile = aws cloudformation describe-stacks --stack-name fcj-week11 --query "Stacks[0].Outputs[?OutputKey=='InstanceProfileName'].OutputValue" --output text

Write-Output "Populating CodeCommit..."
# Prepare files
$buildspec = '
version: 0.2
phases:
  build:
    commands:
      - echo Build started on `date`
      - echo Compiling the code...
artifacts:
  files:
    - index.html
    - appspec.yml
    - scripts/**/*
'
$appspec = '
version: 0.0
os: linux
files:
  - source: /index.html
    destination: /var/www/html/
hooks:
  BeforeInstall:
    - location: scripts/install_dependencies.sh
      timeout: 300
      runas: root
  ApplicationStart:
    - location: scripts/start_server.sh
      timeout: 300
      runas: root
'
$indexHtml = '<h1>Welcome to FCJ Week 11 CI/CD</h1>'
$installDeps = '#!/bin/bash
yum install -y httpd'
$startServer = '#!/bin/bash
systemctl start httpd
systemctl enable httpd'

Set-Content -Path scratch/buildspec.yml -Value $buildspec -Encoding Ascii
Set-Content -Path scratch/appspec.yml -Value $appspec -Encoding Ascii
Set-Content -Path scratch/index.html -Value $indexHtml -Encoding Ascii
New-Item -ItemType Directory -Force -Path scratch/scripts | Out-Null
Set-Content -Path scratch/scripts/install_dependencies.sh -Value $installDeps -Encoding Ascii
Set-Content -Path scratch/scripts/start_server.sh -Value $startServer -Encoding Ascii

# Make an initial commit via AWS CLI
# We need to zip the files and put them into CodeCommit, or just create a first commit with one file and then add more.
# Since CodeCommit create-commit CLI handles multiple files, it's easier to use a Python script.
$pyScript = @"
import boto3, os, base64

client = boto3.client('codecommit', region_name='ap-southeast-2')
repo = '$repoName'

def get_content(path):
    with open(path, 'rb') as f:
        return f.read()

try:
    response = client.create_commit(
        repositoryName=repo,
        branchName='main',
        authorName='Admin',
        email='admin@example.com',
        commitMessage='Initial commit',
        putFiles=[
            {'filePath': 'buildspec.yml', 'fileContent': get_content('scratch/buildspec.yml')},
            {'filePath': 'appspec.yml', 'fileContent': get_content('scratch/appspec.yml')},
            {'filePath': 'index.html', 'fileContent': get_content('scratch/index.html')},
            {'filePath': 'scripts/install_dependencies.sh', 'fileContent': get_content('scratch/scripts/install_dependencies.sh')},
            {'filePath': 'scripts/start_server.sh', 'fileContent': get_content('scratch/scripts/start_server.sh')}
        ]
    )
    print("Created commit:", response['commitId'])
except Exception as e:
    print("CodeCommit error:", e)
"@
Set-Content -Path scratch/commit.py -Value $pyScript -Encoding Ascii
python scratch/commit.py

Write-Output "Launching EC2 for CodeDeploy..."
$amiId = aws ssm get-parameters --names /aws/service/ami-amazon-linux-latest/al2023-ami-kernel-6.1-x86_64 --query "Parameters[0].Value" --output text
$vpcId = aws ec2 describe-vpcs --filters "Name=isDefault,Values=true" --query "Vpcs[0].VpcId" --output text
$subnetId = aws ec2 describe-subnets --filters "Name=vpc-id,Values=$vpcId" --query "Subnets[0].SubnetId" --output text
$sgId = aws ec2 describe-security-groups --filters "Name=vpc-id,Values=$vpcId" "Name=group-name,Values=default" --query "SecurityGroups[0].GroupId" --output text

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

$instId = aws ec2 run-instances --image-id $amiId --count 1 --instance-type t2.micro --subnet-id $subnetId --security-group-ids $sgId --iam-instance-profile Name=$instanceProfile --user-data $userDataB64 --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=CodeDeployServer},{Key=Environment,Value=production}]" --query "Instances[0].InstanceId" --output text

Write-Output "Creating CodePipeline..."
$pipelineJson = @"
{
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
"@
Set-Content -Path scratch/pipeline.json -Value $pipelineJson -Encoding Ascii
aws codepipeline create-pipeline --cli-input-json file://scratch/pipeline.json | Out-Null

Write-Output "Week 11 Deployment Completed Successfully!"
