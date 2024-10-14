# Triển khai module VPC
module "vpc" {
  source = "../../modules/vpc"  # Đường dẫn đến module VPC
  vpc_name = "focela-staging-vpc"
  vpc_cidr = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  azs = var.azs
}