# Define the main Virtual Private Cloud (VPC) for Focela Technologies
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr             # The network range for the VPC
  enable_dns_support   = true                     # Enable DNS support for instances within the VPC
  enable_dns_hostnames = true                     # Enable DNS hostnames for public-facing instances
  tags = {
    Name = var.vpc_name  # Tagging the VPC for easy identification in AWS
  }
}

# Attach an Internet Gateway to allow external access to the VPC
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "focela-igw"           # Internet Gateway specific to Focela Technologies
  }
}

# Create a Route Table for public subnets to route internet traffic
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"                     # Route all traffic to the internet
    gateway_id = aws_internet_gateway.main.id     # Route through the Internet Gateway
  }
  tags = {
    Name = "focela-main-route-table"     # Main route table for public subnets in Focela's VPC
  }
}

# Associate public subnets with the route table
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.main.id
}
