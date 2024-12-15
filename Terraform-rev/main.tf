# Proveedor GCP
provider "google" {
  project = var.project
  region  = var.region
}

# Configuración del Clúster GKE
resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region

  initial_node_count = 3

  node_config {
    machine_type = "e2-medium"

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}

# Base de datos gestionada (Cloud SQL)
resource "google_sql_database_instance" "cloudsql" {
  name             = "mysql-instance"
  region           = var.region
  database_version = "MYSQL_8_0"

  settings {
    tier = "db-f1-micro"
    backup_configuration {
      enabled = true
    }
  }
}


# Despliegue de Helm en GKE
resource "helm_release" "laravel_mysql" {
  name       = "laravel-mysql"
  repository = "https://github.com/Bryyyan93/practica_final.git"
  chart      = "charts"

  values = [
    file("${path.module}/../charts/values.yaml")
  ]

  set {
    name  = "db.secrets.rootPassword"
    value = "rootpassword"
  }

  set {
    name  = "ingress.host"
    value = "practica.local"
  }
}

# Load Balancer (Ingress)
resource "kubernetes_ingress_v1" "laravel_ingress" {
  metadata {
    name      = "laravel-ingress"
    namespace = "laravel-mysql"

    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
    }
  }

  spec {
    rule {
      host = "practica.local"

      http {
        path {
          path     = "/"
          path_type = "Prefix"

          backend {
            service {
              name = "laravel-mysql-nginx"
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}

# Outputs
output "gke_cluster_endpoint" {
  value = google_container_cluster.primary.endpoint
}

output "cloudsql_instance_connection_name" {
  value = google_sql_database_instance.cloudsql.connection_name
}

output "ingress_host" {
  value = "http://practica.local"
}
