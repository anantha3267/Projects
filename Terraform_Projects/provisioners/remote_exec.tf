provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0" # Replace with a valid AMI ID
  instance_type = "t2.micro"
  key_name      = "my-key"

  tags = {
    Name = "Terraform-Instance"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"  # Change to "ubuntu" if using Ubuntu
    private_key = file("~/.ssh/my-key.pem")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo amazon-linux-extras enable nginx1",
      "sudo yum install -y nginx",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]
  }
}
