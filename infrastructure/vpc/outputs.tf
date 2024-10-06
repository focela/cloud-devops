# Output the VPC ID
output "vpc_id" {
  value       = aws_vpc.focela_vpc.id
  description = "ID of the created VPC"
}

# Output the IDs of the public subnets
output "public_subnet_ids" {
  value       = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
  description = "IDs of the public subnets"
}

# Output the IDs of the private subnets
output "private_subnet_ids" {
  value       = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
  description = "IDs of the private subnets"
}

# Output the NAT Gateway ID
output "nat_gateway_id" {
  value       = aws_nat_gateway.nat_gw.id
  description = "ID of the NAT Gateway"
}
