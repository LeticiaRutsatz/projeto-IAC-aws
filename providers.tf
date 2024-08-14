terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.60.0"
    }
  }

  backend "s3" {
    bucket    = "rockeseat-state-bucket-tf"
    region  = "us-east-1"
    key     = "terraform.tfstate"
    encrypt = true

    profile = "leticiarutsatz"
  }

}

provider "aws" {
  profile = "leticiarutsatz"
}

//bucket para salvar o estado no S3, assim o arquivo do tfstate não fica visível no repositório, 
//mas sim em um arquivo s3
resource "aws_s3_bucket" "terraform_state" { 
  bucket = var.state_bucket

  lifecycle {
    prevent_destroy = true //não vai deletar meu bucket caso eu dê o comando de destroy
  }
}

//habilita o versionamento
resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.bucket

  versioning_configuration {
    status = "Enabled"
  }

  depends_on = [aws_s3_bucket.terraform_state]

}