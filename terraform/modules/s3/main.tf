resource "aws_s3_bucket" "default" {
  bucket = var.bucket_name

  # Habilitar versionado
  versioning {
    enabled = true
  }

  # Prevenir la destrucción accidental del bucket
  lifecycle {
    prevent_destroy = true
  }

  # Regla de ciclo de vida para la expiración de objetos
  lifecycle_rule {
    enabled = true
    expiration {
      days = 30
    }
  }
}

# Bloque para gestionar los accesos públicos
resource "aws_s3_bucket_public_access_block" "default" {
  bucket = aws_s3_bucket.default.bucket

  block_public_acls = true   # Prevenir acceso público explícito
  ignore_public_acls = true  # Ignorar las ACLs públicas en los objetos
}

