# Output the public IP of the Elastic IP associated with the Bastion instance
output "bastion_public_ip" {
  description = "The Elastic IP associated with the Bastion instance"
  value       = aws_eip.bastion_eip.public_ip
}

# Output the security group ID of the Bastion instance
output "bastion_security_group_id" {
  description = "The ID of the Bastion security group"
  value       = aws_security_group.bastion_sg.id
}
