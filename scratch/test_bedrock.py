import boto3
import json

try:
    client = boto3.client('bedrock-runtime', region_name='us-east-1')
    response = client.invoke_model(
        modelId='anthropic.claude-3-haiku-20240307-v1:0',
        body=json.dumps({
            "anthropic_version": "bedrock-2023-05-31",
            "max_tokens": 50,
            "messages": [{"role": "user", "content": "Hello"}]
        })
    )
    result = json.loads(response.get('body').read())
    print("Success:", result)
except Exception as e:
    print("Error:", e)
