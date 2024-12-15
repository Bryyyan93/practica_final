resource "google_container_cluster" "primary" {
  name     = "laravel-mysql-cluster"
  location = "europe-west3"

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
