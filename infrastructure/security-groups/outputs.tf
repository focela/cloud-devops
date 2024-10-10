# Output the ID of the GitLab EKS security group
output "gitlab_eks_security_group_id" {
  description = "The ID of the GitLab EKS security group"
  value       = aws_security_group.gitlab_eks_sg.id
}

# Output the ID of the Redis security group
output "redis_security_group_id" {
  description = "The ID of the Redis security group"
  value       = aws_security_group.redis_sg.id
}

# Output the ID of the PostgreSQL RDS security group
output "postgres_security_group_id" {
  description = "The ID of the PostgreSQL RDS security group"
  value       = aws_security_group.postgres_sg.id
}

# Output the ID of the EKS node security group
output "eks_node_security_group_id" {
  description = "The ID of the EKS node security group"
  value       = aws_security_group.eks_node_sg.id
}

# Output the ID of the EKS control plane security group
output "eks_control_security_group_id" {
  description = "The ID of the EKS control plane security group"
  value       = aws_security_group.eks_control_sg.id
}
