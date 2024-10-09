# Provider configuration for AWS
provider "aws" {
  region = var.aws_region
}

# VPC creation
resource "aws_vpc" "focela_vpc" {
  cidr_block       = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "focela-vpc"
  }
}

# Public Subnet A
resource "aws_subnet" "focela_public_subnet_a" {
  vpc_id     = aws_vpc.focela_vpc.id
  cidr_block = var.public_subnet_a_cidr
  availability_zone = "${var.aws_region}a"

  tags = {
    Name = "focela-public-subnet-a"
  }
}

# Public Subnet C
resource "aws_subnet" "focela_public_subnet_c" {
  vpc_id     = aws_vpc.focela_vpc.id
  cidr_block = var.public_subnet_c_cidr
  availability_zone = "${var.aws_region}c"

  tags = {
    Name = "focela-public-subnet-c"
  }
}

# Private Subnet A
resource "aws_subnet" "focela_private_subnet_a" {
  vpc_id     = aws_vpc.focela_vpc.id
  cidr_block = var.private_subnet_a_cidr
  availability_zone = "${var.aws_region}a"

  tags = {
    Name = "focela-private-subnet-a"
  }
}

# Private Subnet C
resource "aws_subnet" "focela_private_subnet_c" {
  vpc_id     = aws_vpc.focela_vpc.id
  cidr_block = var.private_subnet_c_cidr
  availability_zone = "${var.aws_region}c"

  tags = {
    Name = "focela-private-subnet-c"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "focela_igw" {
  vpc_id = aws_vpc.focela_vpc.id

  tags = {
    Name = "focela-internet-gateway"
  }
}

# NAT Gateway for private subnets
resource "aws_nat_gateway" "focela_nat_gw" {
  allocation_id = aws_eip.focela_nat_eip.id
  subnet_id     = aws_subnet.focela_public_subnet_a.id

  tags = {
    Name = "focela-nat-gateway"
  }
}

# Elastic IP for NAT Gateway
resource "aws_eip" "focela_nat_eip" {
  domain = "vpc"

  tags = {
    Name = "focela-nat-eip"
  }
}

# Route table for public subnets
resource "aws_route_table" "focela_public_rt" {
  vpc_id = aws_vpc.focela_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.focela_igw.id
  }

  tags = {
    Name = "focela-public-route-table"
  }
}

# Route table association for Public Subnet A
resource "aws_route_table_association" "focela_public_subnet_a_rt_assoc" {
  subnet_id      = aws_subnet.focela_public_subnet_a.id
  route_table_id = aws_route_table.focela_public_rt.id
}

# Route table association for Public Subnet C
resource "aws_route_table_association" "focela_public_subnet_c_rt_assoc" {
  subnet_id      = aws_subnet.focela_public_subnet_c.id
  route_table_id = aws_route_table.focela_public_rt.id
}

# Route table for private subnets
resource "aws_route_table" "focela_private_rt" {
  vpc_id = aws_vpc.focela_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.focela_nat_gw.id
  }

  tags = {
    Name = "focela-private-route-table"
  }
}

# Route table association for Private Subnet A
resource "aws_route_table_association" "focela_private_subnet_a_rt_assoc" {
  subnet_id      = aws_subnet.focela_private_subnet_a.id
  route_table_id = aws_route_table.focela_private_rt.id
}

# Route table association for Private Subnet C
resource "aws_route_table_association" "focela_private_subnet_c_rt_assoc" {
  subnet_id      = aws_subnet.focela_private_subnet_c.id
  route_table_id = aws_route_table.focela_private_rt.id
}
