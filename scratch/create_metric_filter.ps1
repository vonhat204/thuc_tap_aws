Write-Output "Creating Log Group and Metric Filter..."

# Create Log Group
aws logs create-log-group --log-group-name "Lab8-LogGroup"

# Create Metric Filter
aws logs put-metric-filter --log-group-name "Lab8-LogGroup" --filter-name "PageViewFilter" --filter-pattern "[ip, user, status_code=200, ...]" --metric-transformations metricName=PageViewCount,metricNamespace=LogMetrics,metricValue=1

Write-Output "Metric Filter created successfully."
