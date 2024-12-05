# Usar la VPC existente
data "aws_vpc" "existing" {
  id = "vpc-0a1c2ce95b4d0f7bc"  # ID de la VPC existente
}

# Usar las subredes públicas existentes
data "aws_subnet" "public" {
  count = 2
  id    = element(
    [
      "subnet-0396072a3ee90c03",  # ID de la primera subred pública
      "subnet-0bd7911485b6533d8"   # ID de la segunda subred pública
    ],
    count.index
  )
}

# Usar el Security Group ya existente
data "aws_security_group" "existing_sg" {
  id = "sg-08d290d47e216ac56"  # ID del security group existente
}

module "iam" {
  source                  = "./modules/iam"
  project_id              = var.project_id
  eks_assume_role_policy  = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Action   = "sts:AssumeRole"
        project_id = var.project_id
      }
    ]
  })
}

# Módulo de S3
module "s3" {
  source      = "./modules/s3"
  bucket_name = "practica-final-bucket"  # Asegúrate de que sea único
}

# Módulo de Load Balancer
module "load_balancer" {
  source             = "./modules/load_balancer"
  cluster_name      = "practica-final-cluster"
  security_group_id  = data.aws_security_group.existing_sg.id  # Usar el Security Group existente
  subnet_ids         = data.aws_subnet.public[*].id            # Usar las subredes públicas existentes
  vpc_id             = data.aws_vpc.existing.id                # Usar la VPC existente
}

# Módulo de EKS
module "eks" {
  source            = "./modules/eks"
  cluster_name      = "practica-final-cluster"
  cluster_version   = "1.24"  # Aquí defines la versión del cluster
  vpc_id            = data.aws_vpc.existing.id   # Usar el ID de la VPC existente
  subnet_ids        = data.aws_subnet.public[*].id  # Usar las subredes públicas

  node_count        = 2
  node_machine_type = "t3.medium"
}

module "rds" {
  source         = "./modules/rds"
  db_name        = jsondecode(data.aws_secretsmanager_secret_version.db_name_value.secret_string).db_name
  db_username    = jsondecode(data.aws_secretsmanager_secret_version.db_username_value.secret_string).db_username
  db_password    = jsondecode(data.aws_secretsmanager_secret_version.db_password_value.secret_string).db_password
  db_instance_class = "db.t3.medium"  # O cualquier valor que necesites
  
}

# Kubernetes Deployment para la aplicación PHP
resource "kubernetes_deployment" "php_app" {
  metadata {
    name      = "php-app"
    namespace = "default"
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "php-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "php-app"
        }
      }

      spec {
        container {
          name  = "php-container"
          image = "php:8.3-fpm"  # Cambia si usas una imagen personalizada

          # Definir los puertos NO aquí, sino en los archivos de servicio y de ingress
          # Los puertos son gestionados en los archivos YAML de Kubernetes (mysql-service.yaml, php-service.yaml)
          
          env {
            name  = "DB_HOST"
            value = module.rds.endpoint
          }
          env {
            name  = "DB_NAME"
            value = "practica_final"
          }
          env {
            name  = "DB_USER"
            value = "admin"
          }
          env {
            name  = "DB_PASSWORD"
            value = var.db_password
          }
        }
      }
    }
  }
}

# Kubernetes Service para PHP (sin puertos, ya están definidos en los archivos YAML)
resource "kubernetes_service" "php_service" {
  metadata {
    name      = "php-app-service"
    namespace = "default"
  }

  spec {
    selector = {
      app = "php-app"
    }

    # No se definen puertos aquí, porque ya están configurados en el archivo php-service.yaml
    type = "LoadBalancer"
  }
}

# Kubernetes Service para MySQL (similar, gestionado en mysql-service.yaml)
resource "kubernetes_service" "mysql_service" {
  metadata {
    name      = "mysql"
    namespace = "default"
  }

  spec {
    selector = {
      app = "mysql"
    }

    # No se definen puertos aquí, ya están gestionados en mysql-service.yaml
    type = "LoadBalancer"
  }
}
# Recuperar la contraseña de la base de datos desde AWS Secrets Manager
data "aws_secretsmanager_secret" "db_password" {
  name = "db_password_secret"
}

data "aws_secretsmanager_secret_version" "db_password_value" {
  secret_id = data.aws_secretsmanager_secret.db_password.id
}

# Recuperar el nombre de la base de datos desde AWS Secrets Manager
data "aws_secretsmanager_secret" "db_name" {
  name = "db_name_secret"
}

data "aws_secretsmanager_secret_version" "db_name_value" {
  secret_id = data.aws_secretsmanager_secret.db_name.id
}

# Recuperar el nombre de usuario de la base de datos desde AWS Secrets Manager
data "aws_secretsmanager_secret" "db_username" {
  name = "db_username_secret"
}

data "aws_secretsmanager_secret_version" "db_username_value" {
  secret_id = data.aws_secretsmanager_secret.db_username.id
}
