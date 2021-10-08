##### PARAMETROS OPCIONAIS #####

variable "region" {
  description = "Região AWS aonde os recursos serão provisionados"
  default     = "us-east-2"
}

variable "turma" {
  description = "Número da Turma"
  default     = "12638"
}

variable "server_port" {
  description = "Porta padrão do serviço HTTP que subirá nas instâncias"
  type        = number
  default     = 80
}