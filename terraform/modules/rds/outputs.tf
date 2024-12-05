output "endpoint" {
  description = "El endpoint de la instancia RDS"
  value       = aws_db_instance.default.endpoint
}

output "db_name" {
  description = "Nombre de la base de datos"
  value       = aws_db_instance.default.name
}

output "db_instance_class" {
  description = "Clase de la instancia de la base de datos"
  value       = aws_db_instance.default.instance_class
}

output "db_subnet_group" {
  description = "El nombre del grupo de subnets de la base de datos"
  value       = aws_db_subnet_group.default.name
}
