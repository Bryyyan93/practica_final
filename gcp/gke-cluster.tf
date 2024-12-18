# gke-cluster.tf
resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region

  # Numero inicial de nodos en el cluster
  initial_node_count = var.node_count

  # Desactivar protección de eliminación
  deletion_protection = false

  node_config {
    # Máquina más pequeña y económica.
    machine_type = var.machine_type
    # Reducir el tamaño del disco a 20 GB en lugar de 100 GB por nodo.
    disk_size_gb = var.disk_size_gb
    disk_type    = var.disk_type # Usar discos estándar en lugar de SSD.
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
