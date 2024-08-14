//referencia para o terraform que o modulo está neste caminho
//caso o modulo fosse criado aqui na raiz, não precisaria dessa referencia
module "s3" {
  source         = "./modules/s3"
  s3_bucket_name = "rocketseat-iac" //passa o valor default para variavel
  s3_tags = {
    Iac = true
  }
}

module "cloudfront" {
  source             = "./modules/cloudfront"
  origin_id          = module.s3.bucket_id //pegando valor dos outputs do modulo s3
  bucket_domain_name = module.s3.bucket_domain_name
  cdn_price_class    = "PriceClass_200"
  cdn_tags = {
    Iac = true
  }

  depends_on = [ //criação só cloudfront só acontece depois do s3 ter sido criado
    module.s3
  ]
}

//usando módulo externo
module "sqs" {
  source     = "terraform-aws-modules/sqs/aws"
  name       = "rocketseat-sqs"
  create_dlq = true
  tags = {
    Iac = true
  }
}