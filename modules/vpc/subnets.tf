# Define public subnets in different availability zones for Focela's VPC
resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)

  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidrs[count.index]     # CIDR block for each public subnet
  availability_zone = element(var.azs, count.index)     # Distribute subnets across different availability zones
  map_public_ip_on_launch = true                        # Automatically assign public IP to instances launched here

  tags = {
    Name = "focela-public-subnet-${count.index + 1}"  # Naming for public subnets
  }
}

# Define private subnets in different availability zones for Focela's VPC
resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidrs)

  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidrs[count.index]     # CIDR block for each private subnet
  availability_zone = element(var.azs, count.index)      # Distribute subnets across different availability zones

  tags = {
    Name = "focela-private-subnet-${count.index + 1}"  # Naming for private subnets
  }
}
