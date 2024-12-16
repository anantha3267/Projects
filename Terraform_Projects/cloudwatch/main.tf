provider "aws" {
  region = "us-east-1"  # Specify your AWS region
}

# CloudWatch Metric Alarm for high CPU utilization
resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  alarm_name          = "high-cpu-utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Maximum"
  threshold           = 50
  alarm_description   = "Triggered when CPU exceeds 50% for 2 periods of 1 minute"
  actions_enabled     = true

  # Replace with your SNS Topic ARN
  alarm_actions = [
    "arn:aws:sns:us-east-1:713881786085:high-cpu-alerts"  # Replace with your SNS topic ARN
  ]

  dimensions = {
    InstanceId = "i-06acdf5f39f42e518"  # Replace with your EC2 instance ID
  }
}
