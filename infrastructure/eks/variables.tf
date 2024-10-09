# AWS Region
variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "ap-northeast-1"
}

# Cluster Name
variable "cluster_name" {
  description = "Name of the EKS Cluster"
  type        = string
  default     = "my-eks-cluster"
}

# VPC Subnet IDs
variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}

# Node group instance type
variable "instance_type" {
  description = "EC2 instance type for the worker nodes"
  type        = string
  default     = "t3.medium"
}

# Desired number of worker nodes
variable "desired_capacity" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 2
}

# Maximum number of worker nodes
variable "max_capacity" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 3
}

# Minimum number of worker nodes
variable "min_capacity" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 1
}
