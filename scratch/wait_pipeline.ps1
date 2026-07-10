$pipelineName = "fcj-webapp-pipeline"
Write-Output "Waiting for CodePipeline to complete..."
while ($true) {
    $executionId = aws codepipeline get-pipeline-state --name $pipelineName --query "stageStates[0].latestExecution.pipelineExecutionId" --output text

    $execution = aws codepipeline get-pipeline-state --name $pipelineName | ConvertFrom-Json
    $sourceStatus = $execution.stageStates[0].latestExecution.status
    $buildStatus = $execution.stageStates[1].latestExecution.status
    $deployStatus = $execution.stageStates[2].latestExecution.status

    Write-Output "Source: $sourceStatus, Build: $buildStatus, Deploy: $deployStatus"

    if ($deployStatus -eq "Succeeded" -and $buildStatus -eq "Succeeded" -and $sourceStatus -eq "Succeeded") {
        Write-Output "Overall Pipeline Succeeded!"
        break
    }
    
    $overall = aws codepipeline get-pipeline-execution --pipeline-name $pipelineName --pipeline-execution-id $executionId --query "pipelineExecution.status" --output text
    if ($overall -eq "Failed") {
        Write-Output "Overall Pipeline Failed!"
        break
    }
    Start-Sleep -Seconds 10
}
