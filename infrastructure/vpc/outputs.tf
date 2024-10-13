# Output the VPC ID so other resources can use it
output "focela_vpc_id" {
  value = module.focela_vpc.vpc_id
}

# Output the public subnet IDs to reference in other services
output "focela_vpc_public_subnets" {
  value = module.focela_vpc.public_subnets
}

# Output the private subnet IDs to reference in other services
output "focela_vpc_private_subnets" {
  value = module.focela_vpc.private_subnets
}
