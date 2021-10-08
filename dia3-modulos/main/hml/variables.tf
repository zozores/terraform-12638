variable "region" {
    default = "us-east-2"
}

    
variable "instance_type" {
    default = "t2.micro"
}

variable "mensagem" {
    default = "Ola, Turma 12638 de Homologacao"
}

variable "alb_name" {
    default = "alb-hml-t12638"
}

variable "instance_security_group_name" {
    default = "sginstance-hml-t12638"
}

variable "alb_security_group_name" {
    default = "sglb-hml-t12638"
}

variable "asg_desired_capacity" {
    type = number
    default = 2
}

variable "asg_min_size" {
    type = number
    default = 2
}

variable "asg_max_size" {
    type = number
    default = 2
}