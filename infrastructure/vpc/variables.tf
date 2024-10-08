variable "region" {
  description = "The AWS region to deploy to"
  default     = "ap-northeast-1"
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_a_cidr" {
  description = "CIDR block for public subnet A"
  default     = "10.0.1.0/24"
}

variable "public_subnet_c_cidr" {
  description = "CIDR block for public subnet C"
  default     = "10.0.3.0/24"
}

variable "private_subnet_a_cidr" {
  description = "CIDR block for private subnet A"
  default     = "10.0.2.0/24"
}

variable "private_subnet_c_cidr" {
  description = "CIDR block for private subnet C"
  default     = "10.0.4.0/24"
}
