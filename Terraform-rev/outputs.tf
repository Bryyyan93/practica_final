output "gke_cluster_endpoint" {
  value = google_container_cluster.primary.endpoint
}

output "cloudsql_instance_connection_name" {
  value = google_sql_database_instance.cloudsql.connection_name
}

output "ingress_host" {
  value = "http://practica.local"
}
