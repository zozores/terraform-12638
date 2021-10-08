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
        key            = "prod/terraform.tfstate"
        region         = "us-east-2"
        dynamodb_table = "turma12638-lock"
        encrypt        = true 
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

data "template_file" "init-script" {
  template = "${path.module}/init.sh"

  vars = {
    server_port = var.server_port
    mensagem    = var.mensagem
  }
}

resource "aws_launch_configuration" "lc-t12638" {
  image_id        = data.aws_ami.ubuntu.id
  instance_type   = var.instance_type
  security_groups = [aws_security_group.sg-instance-t12638.id]

  user_data       = data.template_file.init-script.rendered

  # Necessário quando usando um launch configuration com um grupo de auto scaling
  # https://www.terraform.io/docs/providers/aws/r/launch_configuration.html
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg-t12638" {
  launch_configuration = aws_launch_configuration.lc-t12638.name
  vpc_zone_identifier  = data.aws_subnet_ids.default.ids

  target_group_arns = [aws_lb_target_group.tg-t12638.arn]
  health_check_type = "ELB"

  desired_capacity = var.desired_capacity
  min_size         = var.min_size
  max_size         = var.max_size

  tag {
    key                 = "Turma"
    value               = var.turma
    propagate_at_launch = true
  }
}

resource "aws_security_group" "sg-instance-t12638" {
  name = var.instance_security_group_name

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Turma" = var.turma 
  }
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

resource "aws_lb" "lb-t12638" {

  name               = var.alb_name

  load_balancer_type = "application"
  subnets            = data.aws_subnet_ids.default.ids
  security_groups    = [aws_security_group.sg-alb-t12638.id]
}

resource "aws_lb_listener" "http-t12638" {
  load_balancer_arn = aws_lb.lb-t12638.arn
  port              = 80
  protocol          = "HTTP"

  # Por padrão retorna uma página 404
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code  = 404
    }
  }
}

resource "aws_lb_target_group" "tg-t12638" {

  name = var.alb_name

  port     = var.server_port
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener_rule" "http-rule-t12638" {
  listener_arn = aws_lb_listener.http-t12638.arn
  priority     = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg-t12638.arn
  }
}

resource "aws_security_group" "sg-alb-t12638" {

  name = var.alb_security_group_name

  # Permite requests HTTP de entrada
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Permite todos os requests de saída
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}