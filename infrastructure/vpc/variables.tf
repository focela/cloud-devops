# AWS region where resources will be deployed
variable "region" {
  description = "AWS region"
  default     = "ap-northeast-1"
}

# CIDR block for the VPC
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

# CIDR block for public subnet 1
variable "public_subnet_cidr_1" {
  description = "CIDR block for public subnet 1"
  default     = "10.0.1.0/24"
}

# CIDR block for public subnet 2
variable "public_subnet_cidr_2" {
  description = "CIDR block for public subnet 2"
  default     = "10.0.2.0/24"
}

# CIDR block for private subnet 1
variable "private_subnet_cidr_1" {
  description = "CIDR block for private subnet 1"
  default     = "10.0.3.0/24"
}

# CIDR block for private subnet 2
variable "private_subnet_cidr_2" {
  description = "CIDR block for private subnet 2"
  default     = "10.0.4.0/24"
}
