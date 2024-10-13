# Define the AWS region to deploy the resources
variable "aws_region" {
  description = "AWS region to deploy the resources"
  type        = string
  default     = "us-east-1"
}

# Define the CIDR block for the VPC
variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

# Map Availability Zones to CIDR blocks for the public subnets
variable "public_subnets" {
  description = "Map of Availability Zones to CIDR blocks for public subnets"
  type        = map(string)
}

# Map Availability Zones to CIDR blocks for the private subnets
variable "private_subnets" {
  description = "Map of Availability Zones to CIDR blocks for private subnets"
  type        = map(string)
}

# List of IP ranges allowed to access the VPC
variable "allowed_ip_ranges" {
  description = "IP ranges allowed to access the VPC"
  type        = list(string)
}

# Define the environment (e.g., dev, staging, prod)
variable "environment" {
  description = "The deployment environment (e.g., dev, staging, prod)"
  type        = string
}
