variable "region" {
  default = "us-east-2"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami" {
  type    = map
  default = {
    "us-east-2" = "ami-00399ec92321828f5"
    "us-west-2" = "ami-0f6970790b38613ef"
    "us-east-1" = "ami-089b5711e63812c2a"
    "sa-east-1" = "ami-0a62c6929da4659cb"
  }
}

variable "turma" {
    default = "12638"
}