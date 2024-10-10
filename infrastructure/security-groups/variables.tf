# VPC ID where the security groups will be applied
variable "vpc_id" {
  description = "The ID of the VPC where security groups will be applied"
  type        = string
}

# List of allowed CIDR blocks for inbound traffic
variable "allowed_cidr_blocks" {
  description = "List of CIDR blocks allowed for inbound traffic"
  type        = list(string)
}

# VPC Security Group IDs for additional integrations (optional)
variable "vpc_security_group_ids" {
  description = "List of VPC Security Group IDs for additional integrations"
  type        = list(string)
  default     = []
}
