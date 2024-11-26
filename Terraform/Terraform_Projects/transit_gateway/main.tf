provider "aws" {
  region = "us-east-1" # Change to your desired region
}

# Create the Transit Gateway
resource "aws_ec2_transit_gateway" "tgw" {
  description = "Main Transit Gateway"
  tags = {
    Name = "Main-TGW"
  }
}

# Create Transit Gateway Route Table
resource "aws_ec2_transit_gateway_route_table" "tgw_rt" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  tags = {
    Name = "TGW-Route-Table"
  }
}

# Create VPCs
resource "aws_vpc" "vpc1" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "VPC-1"
  }
}

resource "aws_vpc" "vpc2" {
  cidr_block = "10.1.0.0/16"
  tags = {
    Name = "VPC-2"
  }
}

resource "aws_vpc" "vpc3" {
  cidr_block = "10.2.0.0/16"
  tags = {
    Name = "VPC-3"
  }
}

# Create Subnets for VPCs
resource "aws_subnet" "vpc1_subnet" {
  count = 2
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = "10.0.${count.index}.0/24"
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "VPC1-Subnet-${count.index}"
  }
}

resource "aws_subnet" "vpc2_subnet" {
  count = 2
  vpc_id            = aws_vpc.vpc2.id
  cidr_block        = "10.1.${count.index}.0/24"
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "VPC2-Subnet-${count.index}"
  }
}

resource "aws_subnet" "vpc3_subnet" {
  count = 2
  vpc_id            = aws_vpc.vpc3.id
  cidr_block        = "10.2.${count.index}.0/24"
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "VPC3-Subnet-${count.index}"
  }
}

# Data Source for Availability Zones
data "aws_availability_zones" "available" {}

# Transit Gateway Attachments
resource "aws_ec2_transit_gateway_vpc_attachment" "tgw_attachment_1" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  vpc_id             = aws_vpc.vpc1.id
  subnet_ids         = aws_subnet.vpc1_subnet[*].id
  tags = {
    Name = "VPC1-TGW-Attachment"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw_attachment_2" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  vpc_id             = aws_vpc.vpc2.id
  subnet_ids         = aws_subnet.vpc2_subnet[*].id
  tags = {
    Name = "VPC2-TGW-Attachment"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw_attachment_3" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  vpc_id             = aws_vpc.vpc3.id
  subnet_ids         = aws_subnet.vpc3_subnet[*].id
  tags = {
    Name = "VPC3-TGW-Attachment"
  }
}

# Associate TGW Attachments with Route Table
resource "aws_ec2_transit_gateway_route_table_association" "vpc1_assoc" {
  transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.tgw_attachment_1.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_rt.id
}

resource "aws_ec2_transit_gateway_route_table_association" "vpc2_assoc" {
  transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.tgw_attachment_2.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_rt.id
}

resource "aws_ec2_transit_gateway_route_table_association" "vpc3_assoc" {
  transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.tgw_attachment_3.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_rt.id
}

# Transit Gateway Routes for VPC Communication
resource "aws_ec2_transit_gateway_route" "vpc1_to_vpc2" {
  destination_cidr_block = aws_vpc.vpc2.cidr_block
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_rt.id
  transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.tgw_attachment_1.id
}

resource "aws_ec2_transit_gateway_route" "vpc1_to_vpc3" {
  destination_cidr_block = aws_vpc.vpc3.cidr_block
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_rt.id
  transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.tgw_attachment_1.id
}

resource "aws_ec2_transit_gateway_route" "vpc2_to_vpc1" {
  destination_cidr_block = aws_vpc.vpc1.cidr_block
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_rt.id
  transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.tgw_attachment_2.id
}

resource "aws_ec2_transit_gateway_route" "vpc2_to_vpc3" {
  destination_cidr_block = aws_vpc.vpc3.cidr_block
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_rt.id
  transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.tgw_attachment_2.id
}

resource "aws_ec2_transit_gateway_route" "vpc3_to_vpc1" {
  destination_cidr_block = aws_vpc.vpc1.cidr_block
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_rt.id
  transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.tgw_attachment_3.id
}

resource "aws_ec2_transit_gateway_route" "vpc3_to_vpc2" {
  destination_cidr_block = aws_vpc.vpc2.cidr_block
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_rt.id
  transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.tgw_attachment_3.id
}

# Update VPC Route Tables
resource "aws_route" "vpc1_to_tgw" {
  route_table_id         = aws_vpc.vpc1.main_route_table_id
  destination_cidr_block = "10.1.0.0/16"
  transit_gateway_id     = aws_ec2_transit_gateway.tgw.id
}

resource "aws_route" "vpc2_to_tgw" {
  route_table_id         = aws_vpc.vpc2.main_route_table_id
  destination_cidr_block = "10.2.0.0/16"
  transit_gateway_id     = aws_ec2_transit_gateway.tgw.id
}

resource "aws_route" "vpc3_to_tgw" {
  route_table_id         = aws_vpc.vpc3.main_route_table_id
  destination_cidr_block = "10.0.0.0/16"
  transit_gateway_id     = aws_ec2_transit_gateway.tgw.id
}

# Security Groups to Allow Inter-VPC Traffic
resource "aws_security_group" "vpc1_sg" {
  vpc_id = aws_vpc.vpc1.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.vpc2.cidr_block, aws_vpc.vpc3.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
