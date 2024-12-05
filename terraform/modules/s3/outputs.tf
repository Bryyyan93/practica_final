output "bucket_name" {
  description = "Nombre del bucket S3"
  value       = aws_s3_bucket.default.bucket
}

output "bucket_arn" {
  description = "ARN del bucket S3"
  value       = aws_s3_bucket.default.arn
}

output "bucket_url" {
  description = "URL pública del bucket S3"
  value       = aws_s3_bucket.default.website_endpoint
}
