# Output the Security Group ID for GitLab
output "gitlab_security_group_id" {
  value       = aws_security_group.gitlab_sg.id
  description = "ID of the Security Group for GitLab"
}

# Output the Security Group ID for GitLab PostgreSQL
output "gitlab_db_security_group_id" {
  value       = aws_security_group.gitlab_db_sg.id
  description = "ID of the Security Group for GitLab PostgreSQL"
}

# Output the Security Group ID for GitLab Redis
output "gitlab_redis_security_group_id" {
  value       = aws_security_group.gitlab_redis_sg.id
  description = "ID of the Security Group for GitLab Redis"
}
