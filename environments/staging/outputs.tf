# Xuất ID của VPC
output "vpc_id" {
  description = "ID của VPC trong môi trường staging"
  value       = module.vpc.vpc_id
}

# Xuất danh sách public subnets
output "public_subnets" {
  description = "Danh sách public subnets cho môi trường staging"
  value       = module.vpc.public_subnets
}