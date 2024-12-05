variable "aws_region" {
  description = "Región de AWS"
  default     = "eu-west-1"
}

variable "cluster_name" {
  description = "Nombre del clúster de EKS"
  default     = "practica-final-cluster"
}

variable "node_instance_type" {
  description = "Tipo de instancia para los nodos de EKS"
  default     = "t3.medium"
}

variable "node_count" {
  description = "Cantidad de nodos en el clúster"
  default     = 2
}

# Variables para la base de datos
variable "db_username" {
  description = "Usuario de la base de datos"
}

variable "db_password" {
  description = "Contraseña para la base de datos"
}

variable "db_name" {
  description = "Nombre de la base de datos"
  default     = "refactorian"  # Nombre predeterminado para la base de datos
}

# Variables para el bucket S3
variable "s3_bucket_name" {
  description = "Nombre del bucket S3"
  default     = "practica-final-bucket-eu-west-1"
}

# Definir el valor de project_id directamente en main.tf
variable "project_id" {
  description = "ID único del proyecto o prefijo para identificar los recursos IAM"
  default     = "921108067704"  # Tu ID de proyecto de AWS
}
