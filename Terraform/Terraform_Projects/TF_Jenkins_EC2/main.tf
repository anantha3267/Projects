provider "aws" {
  region = "us-east-1"  # Set the AWS region here
}

resource "aws_instance" "example" {
  ami           = "ami-0866a3c8686eaeeba"  # Replace with a valid AMI ID
  instance_type = "t2.micro"  # Replace with your desired EC2 instance type

  tags = {
    Name = "ExampleInstance"
  }
}
