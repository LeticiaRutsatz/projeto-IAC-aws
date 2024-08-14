//variaveis de saida pós criação de recurso

output "bucket_domain_name" {
  value       = aws_s3_bucket.bucket.bucket_domain_name
  sensitive   = false
  description = "Nome de dominio do bucket s3"
}

output "bucket_id" {
  value       = aws_s3_bucket.bucket.id 
  sensitive   = false
  description = "Id do dominio do bucket s3"
}