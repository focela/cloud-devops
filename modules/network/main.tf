# Create a VPC with DNS support and hostnames enabled
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "focela-vpc"
  }
}

# Create an Internet Gateway and attach it to the VPC
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "focela-gateway"
  }
}

# Create public subnets across all availability zones
resource "aws_subnet" "public" {
  count = length(var.availability_zones)

  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(var.vpc_cidr, var.cidrsubnet_newbits, count.index)
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "focela-public-${cidrsubnet(var.vpc_cidr, var.cidrsubnet_newbits, count.index)}"
  }
}

# Create private subnets across all availability zones, used for internal resources
resource "aws_subnet" "private" {
  count = length(var.availability_zones)

  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(var.vpc_cidr, var.cidrsubnet_newbits, length(var.availability_zones) + count.index)
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "focela-private-${cidrsubnet(var.vpc_cidr, var.cidrsubnet_newbits, length(var.availability_zones) + count.index)}",
    "kubernetes.io/cluster/focela" = "shared"
  }
}

# Create an Elastic IP for each NAT Gateway
resource "aws_eip" "this" {
  count = length(var.availability_zones)

  domain = "vpc"

  tags = {
    Name = "focela-eip-ngw-${1 + count.index}"
  }
}

# Create a NAT Gateway in each public subnet
resource "aws_nat_gateway" "this" {
  count = length(var.availability_zones)

  allocation_id = aws_eip.this[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  depends_on    = [aws_internet_gateway.this]

  tags = {
    Name = "focela-nat-gateway-${1 + count.index}"
  }
}

# Create an S3 VPC endpoint for private access to S3 without going through the internet
resource "aws_vpc_endpoint" "this" {
  vpc_id            = aws_vpc.this.id
  service_name      = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = aws_route_table.private[*].id

  tags = {
    Name = "focela-vpce"
  }
}

# Create a public route table and associate it with the Internet Gateway
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "focela-public"
  }
}

# Associate each public subnet with the public route table
resource "aws_route_table_association" "public" {
  count = length(var.availability_zones)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Create private route tables and associate them with NAT gateways
resource "aws_route_table" "private" {
  count = length(var.availability_zones)

  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this[count.index].id
  }

  tags = {
    Name = "focela-private-${1 + count.index}"
  }
}

# Associate each private subnet with the private route table
resource "aws_route_table_association" "private" {
  count = length(var.availability_zones)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}
