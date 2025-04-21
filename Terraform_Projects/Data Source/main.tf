data "aws_vpc" "existing_vpc" {
  id = "vpc-12345678"
}

output "vpc_cidr" {
  value = data.aws_vpc.existing_vpc.cidr_block
}
