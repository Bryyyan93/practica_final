output "cluster_id" {
  description = "ID del clúster EKS"
  value       = module.eks.cluster_id
}

output "cluster_endpoint" {
  description = "Endpoint del clúster EKS"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "ID del grupo de seguridad del clúster EKS"
  value = module.eks.security_group_id

}

output "node_security_group_id" {
  description = "ID del grupo de seguridad del grupo de nodos"
  value       = module.eks.node_security_group_id
}
output "cluster_arn" {
  value = aws_eks_cluster.this.arn
}