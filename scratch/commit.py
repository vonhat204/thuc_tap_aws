import boto3, os, base64

client = boto3.client('codecommit', region_name='ap-southeast-2')
repo = 'fcj-webapp'

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
