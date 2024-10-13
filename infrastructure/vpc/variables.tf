# AWS region where the infrastructure is deployed (US East - N. Virginia)
variable "region" {
  description = "The AWS region where resources will be created"
  default     = "us-east-1"
}

# CIDR block for the VPC
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# Name for the VPC
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

# Availability Zones to deploy the VPC in
variable "azs" {
  description = "List of availability zones"
  type        = list(string)
}

# Public subnets configuration
variable "public_subnets" {
  description = "List of public subnets"
  type        = list(string)
}

# Private subnets configuration
variable "private_subnets" {
  description = "List of private subnets"
  type        = list(string)
}
