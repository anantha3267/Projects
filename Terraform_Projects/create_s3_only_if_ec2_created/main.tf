provider "aws" {
    region = "us-east-1"
}


variable "value" {
    type = number
    default = 0
}

resource "aws_instance" "newinstance" {
    count = var.value
    ami = "ami-0ac4dfaf1c5c0cce9"
    instance_type = "t2.micro"
}

resource "aws_s3_bucket" "newbucket" {
  count = length(aws_instance.newinstance)
  bucket = "my-tf-test-bucket-${aws_instance.newinstance[count.index].id}"
}