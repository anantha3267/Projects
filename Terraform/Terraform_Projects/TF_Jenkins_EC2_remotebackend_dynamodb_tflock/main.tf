provider "aws" {
  region = "us-east-1"  # Set the AWS region here
}

resource "aws_instance" "example" {
  ami           = "xxxxx"  # Replace with a valid AMI ID
  instance_type = "t2.micro"  # Replace with your desired EC2 instance type

  tags = {
    Name = "EC2_Jenkins"
  }
}

# resource "aws_dynamodb_table" "tf_lock" {
#   name           = "tf_lock"
#   billing_mode   = "PAY_PER_REQUEST"
#   hash_key       = "LockId"

#   attribute {
#     name = "LockId"
#     type = "S"
#   }
# }