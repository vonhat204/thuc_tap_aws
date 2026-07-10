
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

