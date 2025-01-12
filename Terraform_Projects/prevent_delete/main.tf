
resource "aws_instance" "important_instance" {
  ami             = "ami-0e2c8caa4b6378d8c"
  instance_type   = "t2.micro"

  
  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name = "Important Instance"
  }

  # Enable termination protection (this will prevent EC2 instance from being terminated)
  disable_api_termination  = "true"
}
