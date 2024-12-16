provider "aws" {
  region = "us-east-1"  # Choose your desired region
}

# IAM Role for Lambda function execution
resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Attach basic Lambda execution policy to the IAM Role
resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Attach EC2 permissions policy to the IAM Role
resource "aws_iam_role_policy" "lambda_ec2_permissions" {
  name = "lambda_ec2_permissions"
  role = aws_iam_role.lambda_exec_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "ec2:DescribeSnapshots",   # Allows describing snapshots
          "ec2:DescribeInstances",   # Allows describing EC2 instances
          "ec2:DescribeVolumes",     # Allows describing EC2 volumes
          "ec2:DeleteSnapshot"       # Allows deleting snapshots
        ]
        Resource = "*"  # Allow these actions on all EC2 resources
      }
    ]
  })
}

# Lambda function resource
resource "aws_lambda_function" "delete_old_snapshots" {
  function_name = "delete_old_snapshots"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"
  timeout       = 300
  memory_size   = 128

  # If you have the zip file locally, use 'filename' to upload
  filename      = "lambda.zip"

  # If you're uploading from S3, use these two lines instead:
  # s3_bucket     = "your-s3-bucket-name"
  # s3_key        = "lambda-code/lambda.zip"
}

# CloudWatch Event Rule to trigger the Lambda every day at 10 AM UTC
resource "aws_cloudwatch_event_rule" "daily_trigger" {
  name        = "daily_trigger"
  description = "Triggers the Lambda function every day at 10 AM UTC"
  schedule_expression = "cron(0 10 * * ? *)"  # Runs at 10 AM UTC every day
}

# CloudWatch Event Target to invoke the Lambda function
resource "aws_cloudwatch_event_target" "lambda_trigger" {
  rule      = aws_cloudwatch_event_rule.daily_trigger.name
  arn       = aws_lambda_function.delete_old_snapshots.arn
}

# Grant CloudWatch permission to invoke the Lambda function
resource "aws_lambda_permission" "allow_cloudwatch_to_invoke" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  principal     = "events.amazonaws.com"
  function_name = aws_lambda_function.delete_old_snapshots.function_name
  source_arn    = aws_cloudwatch_event_rule.daily_trigger.arn
}
