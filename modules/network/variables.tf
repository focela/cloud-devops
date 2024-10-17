# Variable for the CIDR block of the VPC
variable "vpc_cidr" {
  description = "The CIDR range for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# List of availability zones to deploy subnets in
variable "availability_zones" {
  description = "List of availability zones to deploy the subnets"
  type        = list(string)
}

# Number of additional subnet bits for each subnet created
variable "cidrsubnet_newbits" {
  description = "Number of new bits to add when calculating subnets using the cidrsubnet function"
  type        = number
  default     = 8
}

# AWS region where resources will be deployed
variable "region" {
  description = "AWS region to deploy the resources"
  type        = string
}
