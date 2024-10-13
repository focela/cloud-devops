# Define the AWS provider and specify the region
provider "aws" {
  region = var.region  # Use the region variable to set the region
}

# This module creates a VPC for the entire Focela Technologies infrastructure.
# It includes public and private subnets, a NAT gateway, and route tables.
module "focela_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = ">= 3.0"  # Updated to the latest version to avoid deprecated arguments

  # Name of the VPC and its CIDR block
  name    = var.vpc_name  # Using variable for VPC name
  cidr    = var.vpc_cidr  # IP range for the VPC

  # Availability Zones in the specified region
  azs     = var.azs  # Availability Zones are passed via variable

  # Public and private subnets within the VPC
  public_subnets  = var.public_subnets  # Public subnets are passed via variable
  private_subnets = var.private_subnets  # Private subnets are passed via variable

  # Enable a NAT gateway for instances in private subnets to access the internet
  enable_nat_gateway = true
}
