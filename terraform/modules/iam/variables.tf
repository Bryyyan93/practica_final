variable "project_id" {
  description = "ID único del proyecto o prefijo para identificar los recursos IAM"
  type        = string

}
variable "eks_assume_role_policy" {
  description = "Política de confianza para que EKS asuma el rol IAM"
  type        = string
}


variable "eks_role_name" {
  description = "Nombre del rol IAM para EKS"
  type        = string
  default     = "eks-cluster-role"
}

variable "eks_policy_arns" {
  description = "Lista de ARNs de políticas de AWS que se adjuntarán al rol de EKS"
  type        = list(string)
  default     = [
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKSServicePolicy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  ]
}


variable "execution_role_name" {
  description = "Nombre del rol IAM para la ejecución de tareas en el clúster EKS"
  type        = string
  default     = "eks-execution-role"
}

variable "execution_policy_arns" {
  description = "Lista de ARNs de políticas asociadas al rol de ejecución en EKS"
  type        = list(string)
  default     = [
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
  ]
}
