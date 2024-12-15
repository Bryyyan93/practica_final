provider "google" {
  project = "ID-PROYECTO"
  region  = "europe-west3"
}
provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = google_container_cluster.primary.name
}
