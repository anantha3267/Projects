provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0" # Replace with a valid AMI ID
  instance_type = "t2.micro"
  key_name      = "my-key" # Ensure you have the private key for SSH access

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/.ssh/my-key.pem")
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "local-file.txt"   # File on your local system
    destination = "/home/ec2-user/remote-file.txt" # Destination path on the instance
  }
}
