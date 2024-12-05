output "eks_role_arn" {
  description = "ARN del rol IAM asociado al clúster EKS"
  value       = aws_iam_role.eks_role.arn
}

output "eks_role_name" {
  description = "Nombre del rol IAM asociado al clúster EKS"
  value       = aws_iam_role.eks_role.name
}
