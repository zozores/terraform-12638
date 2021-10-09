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
  region     = "us-east-2"
}

variable "projetos" {
  type = map(any)
  default = {
    industrias-wayne = {
      instance_type = "t2.micro"      
    },
    industrias-stark = {
      instance_type = "t3.micro"      
    }
  }
}

data "template_file" "user_data" {
  template = file("${path.module}/user-data.sh")
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

resource "aws_instance" "app" {
  for_each      = var.projetos  
  ami           = data.aws_ami.ubuntu.id
  instance_type = each.value.instance_type
  key_name      = aws_key_pair.app.key_name
  vpc_security_group_ids = [aws_security_group.app.id]           

  user_data = <<-EOF
              #!/bin/bash
              echo "Ola ${each.key}" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF
  
  tags = {
    Empresa = each.key
  }
}

resource "aws_security_group" "app" {
  name  = "sgapp"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

}

resource "aws_key_pair" "app" {
  key_name   = "app"
  public_key = file("~/.ssh/id_rsa.pub")
}
