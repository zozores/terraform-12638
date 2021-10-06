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
  default     = "<h1>Olá, Turma 12638</h1>"
}

variable "server_port" {
  description = "Porta padrão do serviço HTTP que subirá nas instâncias"
  type        = number
  default     = 80
}

variable "alb_name" {
  description = "Nome do Application Load Balancer"
  type        = string
  default     = "alb-t12638"
}

variable "instance_security_group_name" {
  description = "Nome do Security Group das instâncias EC2"
  type        = string
  default     = "sginstance-t12638"
}

variable "alb_security_group_name" {
  description = "Nome do Security Group do Application Load Balancer"
  type        = string
  default     = "sgalb-t12638"
}