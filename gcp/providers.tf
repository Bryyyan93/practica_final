# providers.tf
data "google_client_config" "default" {}

provider "google" {
  project = "pure-pact-444915-s4"
  region  = "us-central1"
}

provider "kubernetes" {
  host                   = google_container_cluster.primary.endpoint
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = google_container_cluster.primary.endpoint
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
  }
}
