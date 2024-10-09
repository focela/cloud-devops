# Output the security group IDs for reference
output "gitlab_sg_id" {
  description = "The ID of the GitLab security group"
  value       = aws_security_group.gitlab_sg.id
}

output "postgresql_sg_id" {
  description = "The ID of the PostgreSQL security group"
  value       = aws_security_group.postgresql_sg.id
}

output "redis_sg_id" {
  description = "The ID of the Redis security group"
  value       = aws_security_group.redis_sg.id
}
