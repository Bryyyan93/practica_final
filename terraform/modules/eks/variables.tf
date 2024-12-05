variable "cluster_name" {}
variable "node_count" {}
variable "node_machine_type" {}
variable "cluster_version" {
  description = "Versión de Kubernetes para el cluster"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC donde se desplegará el cluster"
  type        = string
}

variable "subnet_ids" {
  description = "IDs de las subredes públicas"
  type        = list(string)
}
