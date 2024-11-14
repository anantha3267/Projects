provider "aws" {
  region = "us-east-1"  # Set the AWS region here
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"  # Replace with a valid AMI ID
  instance_type = "t2.micro"  # Replace with your desired EC2 instance type

  tags = {
    Name = "ExampleInstance"
  }
}
