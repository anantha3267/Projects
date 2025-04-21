# Use the AWS provider
provider "aws" {
  region = "us-west-2"
}

# Access the secret in AWS Secrets Manager
data "aws_secretsmanager_secret" "example" {
  name = "my_secret_key"  # Replace with your secret name
}

# Fetch the secret value
data "aws_secretsmanager_secret_version" "example" {
  secret_id = data.aws_secretsmanager_secret.example.id
}

# Use the secret in your resource securely (without putting it in tags)
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  user_data = <<-EOF
              #!/bin/bash
              export SECRET_KEY=${data.aws_secretsmanager_secret_version.example.secret_string}
              # Add further application logic here
              EOF
}
