# /project/directory1/main.tf

provider "aws" {
  region = "us-east-1"
}

# Create VPC
resource "aws_vpc" "example_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
}

# Create Subnet
resource "aws_subnet" "example_subnet" {
  vpc_id     = aws_vpc.example_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}

output "vpc_id" {
  value = aws_vpc.example_vpc.id
}

output "subnet_id" {
  value = aws_subnet.example_subnet.id
}
