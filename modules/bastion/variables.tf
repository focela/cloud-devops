# The AWS region to deploy the resources in
variable "region" {
  description = "The AWS region where the resources will be deployed"
  type        = string
}

# The ID of the VPC where the Bastion instance will be deployed
variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

# List of public subnet IDs where the Bastion instance will be deployed
variable "subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

# The type of the Bastion instance (default: t2.micro)
variable "instance_type" {
  description = "The instance type for the Bastion host"
  type        = string
  default     = "t2.micro"
}

# The key pair name used for SSH access to the Bastion instance
variable "bastion_key_name" {
  description = "The name of an existing key pair to be used with the Bastion instance"
  type        = string
}

# List of IP addresses allowed to SSH into the Bastion instance
variable "whitelistSshIps" {
  description = "List of IP addresses allowed to SSH into the Bastion instance"
  type        = list(string)
}
