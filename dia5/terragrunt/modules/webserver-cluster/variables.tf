##### PARAMETROS REQUERIDOS #####

variable "instance_type" {
  description = "Tipo de instância EC2 padrão"
}

variable "mensagem" {
  description = "Mensagem Padrão do Servidor HTTP"  
}

variable "alb_name" {
  description = "Nome do Application Load Balancer"
  type        = string  
}

variable "instance_security_group_name" {
  description = "Nome do Security Group das instâncias EC2"
  type        = string
}

variable "alb_security_group_name" {
  description = "Nome do Security Group do Application Load Balancer"
  type        = string  
}

variable "asg_desired_capacity" {  
  type        = number
}

variable "asg_min_size" {  
  type        = number
}

variable "asg_max_size" {  
  type        = number
}

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

variable "habilitar_autoscale" {
  description = "Habilita os agendamentos de auto scale"
  type    = bool
  default = false
}

variable "custom_tags" {
  type = map
  default = {
    "Empresa" = "XPTO"
    "Departamento" = "RH"
    "Aplicacao" = "Folha de Pagamento"
  }
}