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

resource "aws_instance" "ec2-turma-12638" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.sg-turma-12638.id]
  key_name               = aws_key_pair.kp-turma-12638.key_name            

  user_data = <<-EOF
              #!/bin/bash
              echo "<h1>Olá Mundo!!</h1>" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  tags = {
    Turma = var.turma
  }
}

resource "aws_security_group" "sg-turma-12638" {
  name = "sgturma12638"

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

  tags = {
    Turma = var.turma
  }
}

resource "aws_key_pair" "kp-turma-12638" {
  key_name   = "kp-turma-12638"
  public_key = file("~/.ssh/id_rsa.pub")

  tags = {
    Turma = var.turma
  }
}