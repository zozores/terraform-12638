variable "region" {
  description = "Região AWS aonde os recursos serão provisionados"
  default     = "us-east-2"
}

variable "bucket_name" {
    description = "Nome do Bucket para armazenar o arquivo de estado"
    default     = "turma12638-state"
}

variable "table_name" {
    description = "Nome da tabela do DynamoDB para o mecanismo de lock do arquivo de estado"
    default     = "turma12638-lock"
}