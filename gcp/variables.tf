# variables.tf
####################################################################################################
# Providers
####################################################################################################
variable "project" {
    description = "El ID del proyecto de GCP"
    type        = string
    default     = "pure-pact-444915-s4"
}

variable "region" {
  description = "Región donde se desplegará la infraestructura"
  type        = string
  default     = "us-central1"
}

####################################################################################################
# gke-cluster
####################################################################################################
variable "cluster_name" {
  description = "Nombre del clúster de GKE"
  type        = string
  default     = "gke-cluster"
}

variable "node_count" {
  description = "Numero inicial de nodos en el cluster"
  type        = number
  default     = 2
}

variable "machine_type" {
  description = "Tipo de máquina para los nodos del clúster"
  type        = string
  default     = "e2-medium"
}

variable "disk_size_gb" {
  description = "Tamaño del disco en GB para cada nodo"
  type        = number
  default     = 20
}

variable "disk_type" {
  description = "Tipo de disco para los nodos"
  type        = string
  default     = "pd-standard"
}

####################################################################################################
# Helm-release
####################################################################################################
variable "helm_release_name" {
  description = "El nombre del release de Helm"
  type        = string
  default     = "laravel-mysql"
}

variable "namespace" {
  description = "El namespace donde se desplegará el Helm Release"
  type        = string
  default     = "laravel-mysql"
}

variable "helm_timeout" {
  description = "Tiempo de espera en segundos para el despliegue del Helm Release"
  type        = number
  default     = 600
}
