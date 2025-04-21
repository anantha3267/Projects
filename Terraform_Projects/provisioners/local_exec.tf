resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0" # Replace with a valid AMI ID
  instance_type = "t2.micro"
  key_name      = "my-key"

  provisioner "local-exec" {
    command = "echo Instance ${self.public_ip} has been created >> instance-info.txt"
  }
}
