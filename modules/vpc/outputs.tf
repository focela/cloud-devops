# Output the ID of the VPC
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.focela_vpc.id
}

# Output the IDs of the private subnets, mapping them by availability zone
output "private_subnets" {
  description = "List of private subnet IDs"
  value       = { for az, subnet in aws_subnet.focela_private_subnets : az => subnet.id }
}

# Output the IDs of the public subnets, mapping them by availability zone
output "public_subnets" {
  description = "List of public subnet IDs"
  value       = { for az, subnet in aws_subnet.focela_public_subnets : az => subnet.id }
}

# Output the ID of the security group for the VPC
output "vpc_security_group_id" {
  description = "ID of the Security Group for the VPC"
  value       = aws_security_group.focela_vpc_sg.id
}
