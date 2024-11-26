provider "aws" {
  region = "us-west-2"
}

# Create VPC 1
resource "aws_vpc" "vpc_1" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "VPC-1"
  }
}

# Create VPC 2
resource "aws_vpc" "vpc_2" {
  cidr_block = "10.1.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "VPC-2"
  }
}

# Create VPC Peering Connection
resource "aws_vpc_peering_connection" "peer_connection" {
  vpc_id      = aws_vpc.vpc_1.id
  peer_vpc_id = aws_vpc.vpc_2.id
  peer_region = "us-west-2"  # Both VPCs are in the same region

  tags = {
    Name = "VPC-Peering-Connection"
  }
}

# Route to VPC 2 from VPC 1
resource "aws_route" "vpc_1_to_vpc_2" {
  route_table_id              = aws_vpc.vpc_1.default_route_table_id
  destination_cidr_block      = aws_vpc.vpc_2.cidr_block
  vpc_peering_connection_id   = aws_vpc_peering_connection.peer_connection.id

  depends_on = [aws_vpc_peering_connection.peer_connection]
}

# Route to VPC 1 from VPC 2
resource "aws_route" "vpc_2_to_vpc_1" {
  route_table_id              = aws_vpc.vpc_2.default_route_table_id
  destination_cidr_block      = aws_vpc.vpc_1.cidr_block
  vpc_peering_connection_id   = aws_vpc_peering_connection.peer_connection.id

  depends_on = [aws_vpc_peering_connection.peer_connection]
}
