# Define variables for security groups
variable "gitlab_sg_name" {
  description = "Name of the GitLab Security Group"
  type        = string
  default     = "gitlab-sg"
}

variable "postgresql_sg_name" {
  description = "Name of the PostgreSQL Security Group"
  type        = string
  default     = "postgresql-sg"
}

variable "redis_sg_name" {
  description = "Name of the Redis Security Group"
  type        = string
  default     = "redis-sg"
}

variable "vpc_id" {
  description = "ID of the VPC where security groups will be created"
  type        = string
}

variable "allowed_ssh_cidr" {
  description = "CIDR block allowed to SSH into instances"
  type        = string
  default     = "0.0.0.0/0"
}

variable "allowed_http_cidr" {
  description = "CIDR block allowed to access HTTP"
  type        = string
  default     = "0.0.0.0/0"
}

variable "allowed_https_cidr" {
  description = "CIDR block allowed to access HTTPS"
  type        = string
  default     = "0.0.0.0/0"
}
