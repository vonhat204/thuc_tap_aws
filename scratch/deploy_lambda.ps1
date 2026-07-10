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
Set-Content -Path scratch/trust-policy.json -Value $trustPolicy -Encoding Ascii
$roleName = "LambdaEC2SlackRole"
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
Set-Content -Path scratch/lambda_function.py -Value $lambdaCode -Encoding Ascii
Compress-Archive -Path scratch/lambda_function.py -DestinationPath scratch/lambda_function.zip -Force

aws lambda create-function --function-name EC2SlackNotifier --runtime python3.12 --role $roleArn --handler lambda_function.lambda_handler --zip-file fileb://scratch/lambda_function.zip --environment "Variables={SLACK_WEBHOOK_URL=<YOUR_SLACK_WEBHOOK_URL>}" | Out-Null

# 6. EventBridge Rule
Write-Output "Creating EventBridge Rule..."
$eventPattern = '{"source":["aws.ec2"],"detail-type":["EC2 Instance State-change Notification"]}'
aws events put-rule --name "EC2StateChangeRule" --event-pattern $eventPattern --state ENABLED | Out-Null
$lambdaArn = aws lambda get-function --function-name EC2SlackNotifier --query "Configuration.FunctionArn" --output text
aws lambda add-permission --function-name EC2SlackNotifier --statement-id "EventBridgeInvoke" --action "lambda:InvokeFunction" --principal "events.amazonaws.com" --source-arn (aws events describe-rule --name EC2StateChangeRule --query "Arn" --output text) | Out-Null
aws events put-targets --rule EC2StateChangeRule --targets "Id=1,Arn=$lambdaArn" | Out-Null

Write-Output "Lambda Deployment Complete!"
