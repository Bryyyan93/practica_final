variable "project" {
  description = "El ID del proyecto de GCP"
  default     = "tu-proyecto-gcp"
}

variable "region" {
  description = "Región donde se desplegará la infraestructura"
  default     = "europe-west3""
}

variable "cluster_name" {
  description = "Nombre del clúster de GKE"
  default     = "laravel-mysql-cluster"
}

variable "db_root_password" {
  description = "Password del usuario root para la base de datos"
  type        = string
  sensitive   = true
}

variable "helm_chart_repo" {
  description = "Repositorio de Helm"
  default     = "https://github.com/Bryyyan93/practica_final.git"
}

variable "ingress_host" {
  description = "Host del Ingress"
  default     = "practica.local"
}