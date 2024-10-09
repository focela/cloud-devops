# Output the RDS instance ID
output "rds_instance_id" {
  description = "The ID of the RDS instance"
  value       = aws_db_instance.rds_instance.id
}

# Output the RDS DB identifier
output "rds_db_identifier" {
  description = "The identifier of the RDS database instance"
  value       = aws_db_instance.rds_instance.identifier
}

# Output the RDS endpoint
output "rds_endpoint" {
  description = "The endpoint for the RDS instance"
  value       = aws_db_instance.rds_instance.endpoint
}

# Output the RDS database name
output "rds_db_name" {
  description = "The name of the RDS database"
  value       = aws_db_instance.rds_instance.db_name
}

# Output the RDS security group ID
output "rds_security_group_id" {
  description = "The security group ID for RDS"
  value       = aws_security_group.rds_sg.id
}
