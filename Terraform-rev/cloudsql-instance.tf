resource "google_sql_database_instance" "cloudsql" {
  name             = "mysql-instance"
  region           = "europe-west3"
  database_version = "MYSQL_8_0"

  settings {
    tier = "db-f1-micro"
    backup_configuration {
      enabled = true
    }
  }
}

resource "google_sql_user" "users" {
  name     = "root"
  instance = google_sql_database_instance.cloudsql.name
  password = var.db_root_password
}

resource "google_sql_database" "database" {
  name     = "mydatabase"
  instance = google_sql_database_instance.cloudsql.name
}
