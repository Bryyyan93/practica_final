# gke-cluster.tf
resource "google_container_cluster" "primary" {
  name     = "gke-cluster"
  location = "us-central1"

  initial_node_count = 1

  # Desactivar protección de eliminación
  deletion_protection = false

  node_config {
    # Máquina más pequeña y económica.
    machine_type = "e2-small"
    # Reducir el tamaño del disco a 50 GB en lugar de 100 GB por nodo.
    disk_size_gb = 10
    disk_type    = "pd-standard" # Usar discos estándar en lugar de SSD.
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    metadata = {
      disable-legacy-endpoints = "true"
    } 
  }
  # Desactiva las funciones avanzadas para ahorrar recursos.
  remove_default_node_pool = false
  networking_mode          = "VPC_NATIVE"
  ip_allocation_policy {}

  # Habilitar los costos mínimos de operación.
  resource_labels = {
    environment = "dev"
    cost        = "low"
  }
}
