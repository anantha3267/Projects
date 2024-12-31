# Provider Configuration
provider "aws" {
  region = "us-east-1"
}

# Create an EC2 instance
resource "aws_instance" "example" {
  ami           = "ami-0182f373e66f89c85"  # Amazon Linux 2 AMI ID
  instance_type = "t2.micro"

  # Optional: Add a tag to the instance
  tags = {
    Name = "ExampleInstance"
  }
}
