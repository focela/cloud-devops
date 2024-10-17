# Terraform block to specify version requirements
terraform {
  required_version = ">= 0.12.28"
  required_providers {
    aws = ">= 2.70.0"
  }
}

# Data source to retrieve available AWS availability zones
data "aws_availability_zones" "available" {}

# AWS provider configuration, using a specific profile and region
provider "aws" {
  profile = "default"
  region  = var.region
}

# Network module configuration
module "network" {
  source = "../../modules/network"

  # Input variables passed to the network module
  vpc_cidr           = var.vpc_cidr
  availability_zones = data.aws_availability_zones.available.names
  cidrsubnet_newbits = var.cidrsubnet_newbits
  region             = var.region
}
