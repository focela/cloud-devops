# AWS region where resources will be deployed
variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
}

# CIDR block for the VPC
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

# CIDR block for Public Subnet A
variable "public_subnet_a_cidr" {
  description = "The CIDR block for Public Subnet A"
  type        = string
}

# CIDR block for Public Subnet C
variable "public_subnet_c_cidr" {
  description = "The CIDR block for Public Subnet C"
  type        = string
}

# CIDR block for Private Subnet A
variable "private_subnet_a_cidr" {
  description = "The CIDR block for Private Subnet A"
  type        = string
}

# CIDR block for Private Subnet C
variable "private_subnet_c_cidr" {
  description = "The CIDR block for Private Subnet C"
  type        = string
}
