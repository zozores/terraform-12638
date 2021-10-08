##### PARAMETROS OPCIONAIS #####

variable "region" {
  description = "Região AWS aonde os recursos serão provisionados"
  default     = "us-east-2"
}

variable "instance_type" {
  description = "Tipo de instância EC2 padrão"
  default     = "t2.micro"
}

variable "turma" {
  description = "Número da Turma"
  default     = "12638"
}

variable "mensagem" {
  description = "Mensagem Padrão do Servidor HTTP"
  default     = "Olá, Turma 12638 de Homologação"
}

variable "server_port" {
  description = "Porta padrão do serviço HTTP que subirá nas instâncias"
  type        = number
  default     = 80
}

variable "alb_name" {
  description = "Nome do Application Load Balancer"
  type        = string
  default     = "alb-hml-t12638"
}

variable "instance_security_group_name" {
  description = "Nome do Security Group das instâncias EC2"
  type        = string
  default     = "sginstance-hml-t12638"
}

variable "alb_security_group_name" {
  description = "Nome do Security Group do Application Load Balancer"
  type        = string
  default     = "sgalb-hml-t12638"
}

variable "desired_capacity" {
  type    = number
  default = 2
}

variable "min_size" {
  type    = number
  default = 2
}

variable "max_size" {
  type    = number
  default = 2
}