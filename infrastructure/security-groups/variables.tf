# VPC ID where the security groups will be created
variable "vpc_id" {
  description = "The VPC ID where the security groups will be deployed"
  type        = string
}

# CIDR blocks allowed to access the services (GitLab, Redis, PostgreSQL, etc.)
variable "allowed_cidr_blocks" {
  description = "List of CIDR blocks allowed to connect to the services"
  type        = list(string)
}

# List of Security Group IDs for Redis
variable "redis_sg_id" {
  description = "The security group ID for Redis"
  type        = string
}

# List of Security Group IDs for PostgreSQL (RDS)
variable "postgres_sg_id" {
  description = "The security group ID for PostgreSQL (RDS)"
  type        = string
}

# List of Security Group IDs for GitLab
variable "gitlab_sg_id" {
  description = "The security group ID for GitLab"
  type        = string
}

# List of Security Group IDs for EKS nodes
variable "eks_node_sg_id" {
  description = "The security group ID for EKS nodes"
  type        = string
}

# List of Security Group IDs for EKS control plane
variable "eks_control_sg_id" {
  description = "The security group ID for EKS control plane"
  type        = string
}
