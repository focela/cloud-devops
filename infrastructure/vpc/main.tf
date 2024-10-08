provider "aws" {
  region = "ap-northeast-1"
}

# Define the main VPC for Focela
resource "aws_vpc" "focela_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "focela-vpc"
  }
}

# Define Public Subnet A in ap-northeast-1a
resource "aws_subnet" "focela_public_subnet_a" {
  vpc_id            = aws_vpc.focela_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "focela-public-subnet-a"
  }
}

# Define Public Subnet C in ap-northeast-1c
resource "aws_subnet" "focela_public_subnet_c" {
  vpc_id            = aws_vpc.focela_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "focela-public-subnet-c"
  }
}

# Define Private Subnet A in ap-northeast-1a
resource "aws_subnet" "focela_private_subnet_a" {
  vpc_id            = aws_vpc.focela_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "focela-private-subnet-a"
  }
}

# Define Private Subnet C in ap-northeast-1c
resource "aws_subnet" "focela_private_subnet_c" {
  vpc_id            = aws_vpc.focela_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "focela-private-subnet-c"
  }
}

# Internet Gateway for public access
resource "aws_internet_gateway" "focela_internet_gateway" {
  vpc_id = aws_vpc.focela_vpc.id

  tags = {
    Name = "focela-internet-gateway"
  }
}

# NAT Gateway for private subnets to access the internet
resource "aws_nat_gateway" "focela_nat_gateway" {
  allocation_id = aws_eip.focela_nat_eip.id
  subnet_id     = aws_subnet.focela_public_subnet_a.id

  tags = {
    Name = "focela-nat-gateway"
  }
}

# Elastic IP for NAT Gateway
resource "aws_eip" "focela_nat_eip" {
  domain = "vpc"  # Use domain instead of vpc
}

# Route Table for public subnet
resource "aws_route_table" "focela_public_route_table" {
  vpc_id = aws_vpc.focela_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.focela_internet_gateway.id
  }

  tags = {
    Name = "focela-public-route-table"
  }
}

# Associate Public Subnet A with Public Route Table
resource "aws_route_table_association" "focela_public_a_association" {
  subnet_id      = aws_subnet.focela_public_subnet_a.id
  route_table_id = aws_route_table.focela_public_route_table.id
}

# Associate Public Subnet C with Public Route Table
resource "aws_route_table_association" "focela_public_c_association" {
  subnet_id      = aws_subnet.focela_public_subnet_c.id
  route_table_id = aws_route_table.focela_public_route_table.id
}

# Route Table for private subnet with NAT gateway
resource "aws_route_table" "focela_private_route_table" {
  vpc_id = aws_vpc.focela_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.focela_nat_gateway.id
  }

  tags = {
    Name = "focela-private-route-table"
  }
}

# Associate Private Subnet A with Private Route Table
resource "aws_route_table_association" "focela_private_a_association" {
  subnet_id      = aws_subnet.focela_private_subnet_a.id
  route_table_id = aws_route_table.focela_private_route_table.id
}

# Associate Private Subnet C with Private Route Table
resource "aws_route_table_association" "focela_private_c_association" {
  subnet_id      = aws_subnet.focela_private_subnet_c.id
  route_table_id = aws_route_table.focela_private_route_table.id
}
