// O data source no Terraform busca e referencia recursos já existentes para serem usados no código
data "aws_cloudfront_distribution" "cloudfront" {
  id = aws_cloudfront_distribution.cloudfront.id
}