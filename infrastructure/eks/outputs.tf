output "eks_cluster_id" {
  description = "ID of the EKS Cluster"
  value       = aws_eks_cluster.eks_cluster.id
}

output "eks_cluster_endpoint" {
  description = "Endpoint of the EKS Cluster"
  value       = aws_eks_cluster.eks_cluster.endpoint
}

output "eks_node_group_id" {
  description = "ID of the EKS Node Group"
  value       = aws_eks_node_group.eks_node_group.id
}
