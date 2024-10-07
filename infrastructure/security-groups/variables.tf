# AWS region where resources will be deployed
variable "region" {
  description = "AWS region"
  default     = "ap-northeast-1"
}

# VPC ID where the Security Groups will be created
variable "vpc_id" {
  description = "ID of the VPC to which the Security Groups belong"
}

# CIDR block of the VPC to allow internal communication
variable "vpc_cidr" {
  description = "CIDR block of the VPC to allow internal communication"
}

# Admin IP address to allow SSH access (initially set to allow all IPs)
variable "admin_ip" {
  description = "Admin IP address to allow SSH access"
  default     = "0.0.0.0/0"
}
