


# /project/directory2/main.tf

provider "aws" {
  region = "us-east-1"
}

data "terraform_remote_state" "directory1" {
  backend = "local"
  config = {
    path = "../d1/terraform.tfstate"
  }
}

# Create EC2 instance in the subnet from directory1
resource "aws_instance" "example_instance" {
  ami           = "ami-0f88e80871fd81e91"  # Use a valid AMI ID for us-east-1
  instance_type = "t2.micro"
  subnet_id     = data.terraform_remote_state.directory1.outputs.subnet_id
  associate_public_ip_address = true
  tags = {
    Name = "ExampleInstance"
  }
}
