Write-Output "Starting Week 10 Deployments..."

$amiId = aws ssm get-parameters --names /aws/service/ami-amazon-linux-latest/al2023-ami-kernel-6.1-x86_64 --query "Parameters[0].Value" --output text

# 1. VPC A, B and reuse Lab10-VPC as VPC-C
$vpcs = @{}
$cidrs = @("10.0.0.0/16", "10.1.0.0/16")
$vpcNames = @("VPC-A", "VPC-B")

for ($i=0; $i -lt 2; $i++) {
    $name = $vpcNames[$i]
    Write-Output "Creating $name..."
    $vpc = aws ec2 create-vpc --cidr-block $cidrs[$i] --query "Vpc.VpcId" --output text
    aws ec2 create-tags --resources $vpc --tags Key=Name,Value=$name
    aws ec2 modify-vpc-attribute --vpc-id $vpc --enable-dns-hostnames '{\"Value\":true}'
    
    $subnet = aws ec2 create-subnet --vpc-id $vpc --cidr-block $($cidrs[$i].Replace(".0.0/16", ".1.0/24")) --availability-zone ap-southeast-2a --query "Subnet.SubnetId" --output text
    aws ec2 create-tags --resources $subnet --tags Key=Name,Value="Subnet-$name"
    
    $igw = aws ec2 create-internet-gateway --query "InternetGateway.InternetGatewayId" --output text
    aws ec2 attach-internet-gateway --vpc-id $vpc --internet-gateway-id $igw
    
    $rt = aws ec2 describe-route-tables --filters "Name=vpc-id,Values=$vpc" "Name=association.main,Values=true" --query "RouteTables[0].RouteTableId" --output text
    aws ec2 create-tags --resources $rt --tags Key=Name,Value="RT-$name"
    aws ec2 create-route --route-table-id $rt --destination-cidr-block 0.0.0.0/0 --gateway-id $igw | Out-Null
    
    $sg = aws ec2 create-security-group --group-name "SG-$name" --description "Allow SSH and ICMP" --vpc-id $vpc --query "GroupId" --output text
    aws ec2 authorize-security-group-ingress --group-id $sg --protocol tcp --port 22 --cidr 0.0.0.0/0 | Out-Null
    aws ec2 authorize-security-group-ingress --group-id $sg --protocol icmp --port -1 --cidr 10.0.0.0/8 | Out-Null
    
    Write-Output "Launching Instance $name..."
    $inst = aws ec2 run-instances --image-id $amiId --count 1 --instance-type t2.micro --subnet-id $subnet --security-group-ids $sg --associate-public-ip-address --query "Instances[0].InstanceId" --output text
    aws ec2 create-tags --resources $inst --tags Key=Name,Value="Instance-$name"
    
    $vpcs[$name] = @{ vpc=$vpc; subnet=$subnet; rt=$rt }
}

# 1.5 Setup Lab10-VPC as the third VPC
Write-Output "Setting up Lab10-VPC as the third VPC..."
$lab10vpc = aws ec2 describe-vpcs --filters "Name=tag:Name,Values=Lab10-VPC" --query "Vpcs[0].VpcId" --output text
if ($lab10vpc -eq "None" -or [string]::IsNullOrWhiteSpace($lab10vpc)) {
    # If not exists, try to use Default VPC
    $lab10vpc = aws ec2 describe-vpcs --filters "Name=isDefault,Values=true" --query "Vpcs[0].VpcId" --output text
}
$lab10subnet = aws ec2 describe-subnets --filters "Name=vpc-id,Values=$lab10vpc" --query "Subnets[0].SubnetId" --output text
$lab10rt = aws ec2 describe-route-tables --filters "Name=vpc-id,Values=$lab10vpc" "Name=association.main,Values=true" --query "RouteTables[0].RouteTableId" --output text

if (-not [string]::IsNullOrWhiteSpace($lab10subnet)) {
    Write-Output "Launching Instance Lab10-VPC..."
    $lab10sg = aws ec2 describe-security-groups --filters "Name=vpc-id,Values=$lab10vpc" "Name=group-name,Values=default" --query "SecurityGroups[0].GroupId" --output text
    $inst = aws ec2 run-instances --image-id $amiId --count 1 --instance-type t2.micro --subnet-id $lab10subnet --security-group-ids $lab10sg --associate-public-ip-address --query "Instances[0].InstanceId" --output text
    aws ec2 create-tags --resources $inst --tags Key=Name,Value="Instance-VPC-C"
}

$vpcs["VPC-C"] = @{ vpc=$lab10vpc; subnet=$lab10subnet; rt=$lab10rt }

# 2. Transit Gateway
Write-Output "Creating Transit Gateway..."
$tgw = aws ec2 create-transit-gateway --description "Lab20-TGW" --query "TransitGateway.TransitGatewayId" --output text
aws ec2 create-tags --resources $tgw --tags Key=Name,Value="Lab20-TGW"

# Wait for TGW to be available
Write-Output "Waiting for TGW to be available (can take 2-3 mins)..."
Start-Sleep -Seconds 120

# 3. TGW Attachments
$names = @("VPC-A", "VPC-B", "VPC-C")
foreach ($name in $names) {
    if (-not [string]::IsNullOrWhiteSpace($vpcs[$name].subnet)) {
        Write-Output "Attaching $name to TGW..."
        $attach = aws ec2 create-transit-gateway-vpc-attachment --transit-gateway-id $tgw --vpc-id $vpcs[$name].vpc --subnet-ids $vpcs[$name].subnet --query "TransitGatewayVpcAttachment.TransitGatewayAttachmentId" --output text
        aws ec2 create-tags --resources $attach --tags Key=Name,Value="TGW-Attach-$name"
    }
}

# Wait for attachments
Start-Sleep -Seconds 60

# Add Routes to TGW in VPC Route Tables
foreach ($name in $names) {
    if (-not [string]::IsNullOrWhiteSpace($vpcs[$name].rt)) {
        aws ec2 create-route --route-table-id $vpcs[$name].rt --destination-cidr-block 10.0.0.0/8 --transit-gateway-id $tgw | Out-Null
    }
}

# 4. Lambda IAM Role
Write-Output "Creating Lambda IAM Role..."
$trustPolicy = '{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": { "Service": "lambda.amazonaws.com" },
      "Action": "sts:AssumeRole"
    }
  ]
}'
Out-File -FilePath scratch/trust-policy.json -InputObject $trustPolicy
$roleName = "LambdaEC2SlackRole"
# Ignore error if role already exists
aws iam create-role --role-name $roleName --assume-role-policy-document file://scratch/trust-policy.json | Out-Null
aws iam attach-role-policy --role-name $roleName --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole | Out-Null
Start-Sleep -Seconds 10
$roleArn = aws iam get-role --role-name $roleName --query "Role.Arn" --output text

# 5. Lambda Function
Write-Output "Creating Lambda Function..."
$lambdaCode = '
import json
import os
import urllib.request

def lambda_handler(event, context):
    webhook_url = os.environ.get("SLACK_WEBHOOK_URL", "")
    detail = event.get("detail", {})
    instance_id = detail.get("instance-id", "Unknown")
    state = detail.get("state", "Unknown")
    
    message = f"EC2 Instance {instance_id} state changed to {state}"
    if webhook_url:
        data = json.dumps({"text": message}).encode("utf-8")
        req = urllib.request.Request(webhook_url, data=data, headers={"Content-Type": "application/json"})
        urllib.request.urlopen(req)
    
    return {"statusCode": 200, "body": json.dumps("Message processed")}
'
Out-File -FilePath scratch/lambda_function.py -InputObject $lambdaCode
Compress-Archive -Path scratch/lambda_function.py -DestinationPath scratch/lambda_function.zip -Force

# Ignore error if function already exists
aws lambda delete-function --function-name EC2SlackNotifier 2>$null
aws lambda create-function --function-name EC2SlackNotifier --runtime python3.12 --role $roleArn --handler lambda_function.lambda_handler --zip-file fileb://scratch/lambda_function.zip --environment "Variables={SLACK_WEBHOOK_URL=https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX}" | Out-Null

# 6. EventBridge Rule
Write-Output "Creating EventBridge Rule..."
aws events put-rule --name "EC2StateChangeRule" --event-pattern "{\`"source\`":[\`"aws.ec2\`"],\`"detail-type\`":[\`"EC2 Instance State-change Notification\`"]}" --state ENABLED | Out-Null
$lambdaArn = aws lambda get-function --function-name EC2SlackNotifier --query "Configuration.FunctionArn" --output text
aws lambda remove-permission --function-name EC2SlackNotifier --statement-id "EventBridgeInvoke" 2>$null
aws lambda add-permission --function-name EC2SlackNotifier --statement-id "EventBridgeInvoke" --action "lambda:InvokeFunction" --principal "events.amazonaws.com" --source-arn (aws events describe-rule --name EC2StateChangeRule --query "Arn" --output text) | Out-Null
aws events put-targets --rule EC2StateChangeRule --targets "Id=1,Arn=$lambdaArn" | Out-Null

Write-Output "Deployment Week 10 Complete!"
