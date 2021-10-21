remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "turma12638-state"

    key = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-2"
    encrypt        = true
    dynamodb_table = "turma12638-lock"
  }
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
terraform {
  required_version = ">= 0.12"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.60.0"
    }
  }
}

provider "aws" {
  region     = var.region
}
EOF
}

generate "variables" {
  path = "variables.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
variable "region" {
    default = "us-east-2"
}

variable "instance_type" {}
variable "mensagem" {}
variable "alb_name" {}
variable "instance_security_group_name" {}
variable "alb_security_group_name" {}
variable "asg_desired_capacity" {
    type = number
}
variable "asg_min_size" {
    type = number
}
variable "asg_max_size" {
    type = number
}
EOF
}

terraform {
  extra_arguments "auto_approve" {
    commands = ["apply", "destroy"]

    arguments = [
      "-auto-approve"      
    ]
  }
}

