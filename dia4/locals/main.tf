terraform {
  required_version = ">= 0.12"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.60.0"
    }
  }
}

terraform {
    backend "s3" {
        bucket         = "turma12638-state"
        key            = "workspace/terraform.tfstate"
        region         = "us-east-2"
        dynamodb_table = "turma12638-lock"
        encrypt        = true
    }    
}

provider "aws" {
  region     = var.region
}

locals {
  instance_type = terraform.workspace == "prod" ? "t3.micro" : "t2.micro"
  mensagem      = terraform.workspace == "prod" ? "Olá, PRD" : "Olá, HML"
  alb_name      = terraform.workspace == "prod" ? "alb-prd" : "alb-hml"
  instance_security_group_name = terraform.workspace == "prod" ? "sginstance-prd" : "sginstance-hml"
  alb_security_group_name = terraform.workspace == "prod" ? "sgalb-prd" : "sgalb-hml"
  asg_desired_capacity = terraform.workspace == "prod" ? 4 : 2
  asg_min_size = terraform.workspace == "prod" ? 4 : 2
  asg_max_size = terraform.workspace == "prod" ? 10 : 2
}


# Modulo dentro do filesystem local
module "webserver_cluster" {
    source                       = "../modules/webserver-cluster"

    instance_type                = local.instance_type
    mensagem                     = local.mensagem
    alb_name                     = local.alb_name
    instance_security_group_name = local.instance_security_group_name
    alb_security_group_name      = local.alb_security_group_name
    asg_desired_capacity         = local.asg_desired_capacity
    asg_min_size                 = local.asg_min_size
    asg_max_size                 = local.asg_max_size
    habilitar_autoscale          = true
    region                       = var.region
}

# # Modulo do registry.terraform.io
# module "dynamodb-table" {
#   source  = "terraform-aws-modules/dynamodb-table/aws"
#   version = "1.1.0"

#   hash_key       = "t12638-id"
#   name           = "t12638-modulo"
#   billing_mode   = "PAY_PER_REQUEST"  

#   attributes = [{
#       name = "t12638-id"
#       type = "N"
#     }]
# }

# # Modulo do Git 
# module "example" {    
#   source = "github.com/cloudposse/terraform-example-module.git?ref=master"
#   example = "Hello world!"
# }