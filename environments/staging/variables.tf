# Region cho môi trường staging
variable "aws_region" {
  description = "AWS Region cho môi trường staging"
  type        = string
  default     = "us-east-1"
}

# CIDR cho VPC staging
variable "vpc_cidr" {
  description = "CIDR block cho staging VPC"
  type        = string
  default     = "10.1.0.0/16"
}

# Subnet công cộng cho môi trường staging
variable "public_subnet_cidrs" {
  description = "Danh sách CIDR blocks cho public subnets trong staging"
  type        = list(string)
  default     = ["10.1.1.0/24", "10.1.2.0/24"]
}

# Subnet riêng tư cho môi trường staging
variable "private_subnet_cidrs" {
  description = "Danh sách CIDR blocks cho private subnets trong staging"
  type        = list(string)
  default     = ["10.1.101.0/24", "10.1.102.0/24"]
}

# Availability Zones cho môi trường staging
variable "azs" {
  description = "Danh sách Availability Zones cho subnets trong staging"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

# Cấu hình số lượng worker nodes cho EKS
variable "eks_node_count" {
  description = "Số lượng EKS worker nodes cho staging"
  type        = number
  default     = 2
}
