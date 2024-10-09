# Output the VPC ID
output "vpc_id" {
  description = "The ID of the created VPC"
  value       = aws_vpc.focela_vpc.id
}

# Output Public Subnet A ID
output "public_subnet_a_id" {
  description = "The ID of Public Subnet A"
  value       = aws_subnet.focela_public_subnet_a.id
}

# Output Public Subnet C ID
output "public_subnet_c_id" {
  description = "The ID of Public Subnet C"
  value       = aws_subnet.focela_public_subnet_c.id
}

# Output Private Subnet A ID
output "private_subnet_a_id" {
  description = "The ID of Private Subnet A"
  value       = aws_subnet.focela_private_subnet_a.id
}

# Output Private Subnet C ID
output "private_subnet_c_id" {
  description = "The ID of Private Subnet C"
  value       = aws_subnet.focela_private_subnet_c.id
}

# Output Internet Gateway ID
output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.focela_igw.id
}

# Output NAT Gateway ID
output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = aws_nat_gateway.focela_nat_gw.id
}
