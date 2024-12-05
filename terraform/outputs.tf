output "eks_cluster_endpoint" {
  description = "Endpoint del clúster de EKS"
  value       = module.eks.cluster_endpoint
}

output "rds_endpoint" {
  description = "Endpoint de la base de datos RDS"
  value       = module.rds.endpoint
}

output "s3_bucket_url" {
  description = "URL del bucket S3"
  value       = module.s3.bucket_url
}

output "load_balancer_dns" {
  description = "DNS del Load Balancer"
  value       = module.load_balancer.load_balancer_dns_name
}
