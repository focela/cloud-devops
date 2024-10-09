# Output the Security Group ID for GitLab
output "gitlab_security_group_id" {
  description = "The ID of the security group for GitLab"
  value       = aws_security_group.gitlab_eks_sg.id
}

# Output the Security Group ID for Redis
output "redis_security_group_id" {
  description = "The ID of the security group for Redis"
  value       = aws_security_group.redis_sg.id
}

# Output the Security Group ID for PostgreSQL (RDS)
output "postgres_security_group_id" {
  description = "The ID of the security group for PostgreSQL (RDS)"
  value       = aws_security_group.postgres_sg.id
}

# Output the Security Group ID for EKS nodes
output "eks_node_security_group_id" {
  description = "The ID of the security group for EKS nodes"
  value       = aws_security_group.eks_node_sg.id
}

# Output the Security Group ID for EKS control plane
output "eks_control_security_group_id" {
  description = "The ID of the security group for the EKS control plane"
  value       = aws_security_group.eks_control_sg.id
}
