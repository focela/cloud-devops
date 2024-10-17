# Variable to define the AWS region for deployment
variable "region" {
  description = "The AWS region where resources will be deployed"
  type        = string
  default     = "ap-southeast-1"
}

# Variable for the CIDR block of the VPC
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# Variable for defining subnet size in the VPC
variable "cidrsubnet_newbits" {
  description = "The number of additional bits to add when calculating subnets with the cidrsubnet function"
  type        = number
  default     = 8
}
