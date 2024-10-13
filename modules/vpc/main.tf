# Define AWS provider with the region (region is dynamically passed using a variable)
provider "aws" {
  region = var.aws_region
}

# Create a VPC
resource "aws_vpc" "focela_vpc" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.environment}-focela-vpc"
  }
}

# Internet Gateway for the VPC
resource "aws_internet_gateway" "focela_igw" {
  vpc_id = aws_vpc.focela_vpc.id

  tags = {
    Name = "${var.environment}-focela-igw"
  }
}

# Public subnets for each availability zone
resource "aws_subnet" "focela_public_subnets" {
  for_each = var.public_subnets

  vpc_id            = aws_vpc.focela_vpc.id
  cidr_block        = each.value
  availability_zone = each.key

  tags = {
    Name = "${var.environment}-focela-public-subnet-${each.key}"
  }
}

# Route table for the public subnets
resource "aws_route_table" "focela_public_route_table" {
  vpc_id = aws_vpc.focela_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.focela_igw.id
  }

  tags = {
    Name = "${var.environment}-focela-public-rt"
  }
}

# Associate public subnets with the public route table
resource "aws_route_table_association" "focela_public_subnet_association" {
  for_each = aws_subnet.focela_public_subnets

  subnet_id      = each.value.id
  route_table_id = aws_route_table.focela_public_route_table.id
}

# Private subnets for each availability zone
resource "aws_subnet" "focela_private_subnets" {
  for_each = var.private_subnets

  vpc_id            = aws_vpc.focela_vpc.id
  cidr_block        = each.value
  availability_zone = each.key

  tags = {
    Name = "${var.environment}-focela-private-subnet-${each.key}"
  }
}

# NAT Gateway for the private subnets (placed in one of the public subnets)
resource "aws_nat_gateway" "focela_nat" {
  allocation_id = aws_eip.focela_nat_eip.id
  subnet_id     = aws_subnet.focela_public_subnets["us-east-1a"].id
}

# Elastic IP for the NAT Gateway
resource "aws_eip" "focela_nat_eip" {
  domain = "vpc"
}

# Route table for the private subnets (routes traffic through the NAT Gateway)
resource "aws_route_table" "focela_private_route_table" {
  vpc_id = aws_vpc.focela_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.focela_nat.id
  }

  tags = {
    Name = "${var.environment}-focela-private-rt"
  }
}

# Associate private subnets with the private route table
resource "aws_route_table_association" "focela_private_subnet_association" {
  for_each = aws_subnet.focela_private_subnets

  subnet_id      = each.value.id
  route_table_id = aws_route_table.focela_private_route_table.id
}

# Create a security group for the VPC
resource "aws_security_group" "focela_vpc_sg" {
  name        = "${var.environment}-focela-vpc-sg"
  description = "Security group for services in Focela Technologies VPC"
  vpc_id      = aws_vpc.focela_vpc.id

  # Allow incoming traffic on port 80 (HTTP)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.allowed_ip_ranges
  }

  # Allow incoming traffic on port 443 (HTTPS)
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.allowed_ip_ranges
  }

  # Allow all outgoing traffic (egress)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-focela-sg"
  }
}
