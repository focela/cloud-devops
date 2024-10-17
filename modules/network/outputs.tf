# Output the VPC ID after it's created
output "vpc_id" {
  description = "The ID of the created VPC"
  value       = aws_vpc.this.id
}

# Output a list of all public subnet IDs
output "this_subnet_public_ids" {
  description = "A list of all public subnet IDs"
  value       = aws_subnet.public[*].id
}

# Output a list of all private subnet IDs
output "this_subnet_private_ids" {
  description = "A list of all private subnet IDs"
  value       = aws_subnet.private[*].id
}

# Output the ID of the VPC Endpoint (VPCE)
output "vpce_id" {
  description = "The ID of the created VPC Endpoint (VPCE)"
  value       = aws_vpc_endpoint.this.id
}
