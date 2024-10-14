# Create an Elastic IP for the NAT Gateway
resource "aws_eip" "nat" {
  domain = "vpc"  # Allocate the Elastic IP for the VPC
}

# Define the NAT Gateway for private subnet instances to access the internet
resource "aws_nat_gateway" "public" {
  allocation_id = aws_eip.nat.id                 # Use the allocated Elastic IP
  subnet_id     = aws_subnet.public[0].id        # Place the NAT Gateway in the first public subnet

  tags = {
    Name = "focela-nat-gateway"  # NAT Gateway specific to Focela Technologies
  }
}

# Route table for private subnets to route internet traffic through the NAT Gateway
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.public.id   # Route internet traffic through the NAT Gateway
  }
  tags = {
    Name = "focela-private-route-table"  # Route table for private subnets
  }
}

# Associate private subnets with the private route table
resource "aws_route_table_association" "private" {
  count          = length(var.private_subnet_cidrs)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}
