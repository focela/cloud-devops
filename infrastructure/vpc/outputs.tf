output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.focela_vpc.id
}

output "public_subnet_a_id" {
  description = "The ID of public subnet A"
  value       = aws_subnet.focela_public_subnet_a.id
}

output "public_subnet_c_id" {
  description = "The ID of public subnet C"
  value       = aws_subnet.focela_public_subnet_c.id
}

output "private_subnet_a_id" {
  description = "The ID of private subnet A"
  value       = aws_subnet.focela_private_subnet_a.id
}

output "private_subnet_c_id" {
  description = "The ID of private subnet C"
  value       = aws_subnet.focela_private_subnet_c.id
}
