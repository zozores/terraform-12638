variable "default_instance_type" {
    default = "t2.micro"
}

variable "default_mensagem" {
    default = "Ola, Turma 12638 de Homologacao"
}

variable "default_alb_name" {
    default = "alb-hml-t12638"
}

variable "default_instance_security_group_name" {
    default = "sginstance-hml-t12638"
}

variable "default_alb_security_group_name" {
    default = "sglb-hml-t12638"
}

variable "default_asg_desired_capacity" {
    type = number
    default = 2
}

variable "default_asg_min_size" {
    type = number
    default = 2
}

variable "default_asg_max_size" {
    type = number
    default = 2
}