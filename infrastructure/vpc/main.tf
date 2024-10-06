provider "aws" {
  region = var.region
}

# Create VPC
resource "aws_vpc" "focela_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "focela-vpc"
  }
}

# Create Internet Gateway for VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.focela_vpc.id

  tags = {
    Name = "focela-igw"
  }
}

# Create Route Table and associate with Internet Gateway
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.focela_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "focela-public-route-table"
  }
}

# Create Public Subnets
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.focela_vpc.id
  cidr_block              = var.public_subnet_cidr_1
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "focela-public-subnet-1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.focela_vpc.id
  cidr_block              = var.public_subnet_cidr_2
  availability_zone       = "${var.region}c"
  map_public_ip_on_launch = true

  tags = {
    Name = "focela-public-subnet-2"
  }
}

# Associate Public Subnets with Route Table
resource "aws_route_table_association" "public_assoc_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_assoc_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table.id
}

# Create Private Subnets
resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.focela_vpc.id
  cidr_block        = var.private_subnet_cidr_1
  availability_zone = "${var.region}a"

  tags = {
    Name = "focela-private-subnet-1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.focela_vpc.id
  cidr_block        = var.private_subnet_cidr_2
  availability_zone = "${var.region}c"

  tags = {
    Name = "focela-private-subnet-2"
  }
}

# Create NAT Gateway for Private Subnets
resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "focela-nat-eip"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "focela-nat-gw"
  }
}

# Create Route Table for Private Subnets
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.focela_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "focela-private-route-table"
  }
}

# Associate Private Subnets with Route Table
resource "aws_route_table_association" "private_assoc_1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_assoc_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_route_table.id
}
