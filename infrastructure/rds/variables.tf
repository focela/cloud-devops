# AWS region where resources will be deployed
variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
}

# Subnet IDs for the RDS DB subnet group
variable "subnet_ids" {
  description = "List of subnet IDs for the RDS DB subnet group"
  type        = list(string)
}

# Database identifier for RDS
variable "db_identifier" {
  description = "The identifier for the RDS database instance"
  type        = string
}

# Database username
variable "db_username" {
  description = "The database username"
  type        = string
}

# Database password
variable "db_password" {
  description = "The password for the RDS instance"
  type        = string
}

# Database name
variable "db_name" {
  description = "The name of the RDS database"
  type        = string
}

# Instance class for RDS
variable "db_instance_class" {
  description = "The database instance class"
  type        = string
}

# Allocated storage for RDS
variable "allocated_storage" {
  description = "The allocated storage for the database in GB"
  type        = number
}

# Backup retention period for RDS
variable "backup_retention_period" {
  description = "The number of days to retain backups"
  type        = number
}

# Multi-AZ deployment for RDS
variable "multi_az" {
  description = "Whether to enable multi-AZ deployment"
  type        = bool
}

# Public accessibility for RDS
variable "publicly_accessible" {
  description = "Whether the RDS instance should be publicly accessible"
  type        = bool
}

# Engine version for RDS
variable "engine_version" {
  description = "The version of the database engine"
  type        = string
}

# VPC ID where the RDS instance is deployed
variable "vpc_id" {
  description = "The VPC ID where RDS is deployed"
  type        = string
}

# List of allowed CIDR blocks
variable "allowed_cidr_blocks" {
  description = "The CIDR blocks allowed to connect to the RDS instance"
  type        = list(string)
}

# VPC security group IDs for RDS
variable "vpc_security_group_ids" {
  description = "List of VPC security group IDs to allow access to RDS"
  type        = list(string)
}
