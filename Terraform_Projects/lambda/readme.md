# Lambda Function to Delete Old EBS Snapshots

This Terraform configuration sets up an AWS Lambda function that deletes old EBS snapshots not attached to any volume or associated with any running EC2 instance. The function is triggered every day at 10 AM UTC using CloudWatch Events.

## Steps to Deploy

### 1. **Zip the Python Code**

You need to create a ZIP archive containing your `lambda_function.py` script. Here’s how to do it:

- Navigate to the directory containing `lambda_function.py`.
- Run the following command to create a ZIP file:

  ```bash
  zip lambda.zip lambda_function.py
  ```

Also look into av course day 18
