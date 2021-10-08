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
        key            = "modulos/hml/terraform.tfstate"
        region         = "us-east-2"
        dynamodb_table = "turma12638-lock"
        encrypt        = true
    }    
}

provider "aws" {
  region     = var.region
}

# Modulo dentro do filesystem local
module "webserver_cluster" {
    source                       = "../../modules/webserver-cluster"

    instance_type                = var.instance_type
    mensagem                     = var.mensagem
    alb_name                     = var.alb_name
    instance_security_group_name = var.instance_security_group_name
    alb_security_group_name      = var.alb_security_group_name
    asg_desired_capacity         = var.asg_desired_capacity
    asg_min_size                 = var.asg_min_size
    asg_max_size                 = var.asg_max_size
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