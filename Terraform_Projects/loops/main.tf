provider "aws" {
  region = "us-east-1"  # Choose your region
}

# variable "instances" {
#   type = list(object({
#     ami           = string
#     instance_type = string
#   }))
# }

# resource "aws_instance" "example" {
#   count         = length(var.instances)  # Creates an instance for each entry in the list
#   ami           = var.instances[count.index].ami
#   instance_type = var.instances[count.index].instance_type

#   tags = {
#     Name = "Instance-${count.index + 1}"
#   }
# }

#==============================
variable "instances" {
  type = list(object({
    ami           = string
    instance_type = string
  }))
}

resource "aws_instance" "example" {
  for_each      = { for idx, instance in var.instances : "instance-${idx}" => instance }
  ami           = each.value.ami
  instance_type = each.value.instance_type

  tags = {
    Name = "Instance-${each.key}"
  }
}

