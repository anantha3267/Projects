#!/bin/bash

#S3 EC2 Lambda Users


set -x

# list s3 buckets
aws s3 ls

# list EC2 instance
aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId'

#list lambda
aws lambda list-functions

#list IAM users
aws iam list-users

# Define log file with the current date
# LOG_FILE="/path/to/logs/aws_audit_$(date +\%F).log"

# List S3 buckets
# aws s3 ls >> $LOG_FILE

# List EC2 instances
# aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId' >> $LOG_FILE

# List Lambda functions
# aws lambda list-functions >> $LOG_FILE

# List IAM users
# aws iam list-users >> $LOG_FILE
