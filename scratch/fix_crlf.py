import boto3, os

client = boto3.client('codecommit', region_name='ap-southeast-2')
repo = aws_repo_name = aws_repo_name = 'fcj-webapp'

try:
    branch = client.get_branch(repositoryName=repo, branchName='main')
    parent_commit = branch['branch']['commitId']

    def get_content_lf(path):
        with open(path, 'rb') as f:
            content = f.read()
            return content.replace(b'\r\n', b'\n')

    response = client.create_commit(
        repositoryName=repo,
        branchName='main',
        parentCommitId=parent_commit,
        authorName='Admin',
        email='admin@example.com',
        commitMessage='Fix CRLF line endings',
        putFiles=[
            {'filePath': 'scripts/install_dependencies.sh', 'fileContent': get_content_lf('scratch/scripts/install_dependencies.sh')},
            {'filePath': 'scripts/start_server.sh', 'fileContent': get_content_lf('scratch/scripts/start_server.sh')}
        ]
    )
    print("Created commit:", response['commitId'])
except Exception as e:
    print("CodeCommit error:", e)
