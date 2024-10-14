# Output the VPC ID for future reference
output "vpc_id" {
  description = "ID of the VPC for Focela Technologies"
  value       = aws_vpc.main.id
}

# Output the public subnet IDs for load balancers or other public resources
output "public_subnets" {
  description = "List of public subnet IDs"
  value       = aws_subnet.public[*].id
}

# Output the private subnet IDs for internal services
output "private_subnets" {
  description = "List of private subnet IDs"
  value       = aws_subnet.private[*].id
}
