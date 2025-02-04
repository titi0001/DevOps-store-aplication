variable "aws_region" {
  description = "Região da AWS"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "Perfil da AWS para autenticação"
  type        = string
  default     = "default"
}

variable "db_instance_class" {
  description = "Classe da instância do banco de dados"
  type        = string
  default     = "db.t3.micro"
}

variable "route53_zone_id" {
  description = "ID da Zona do Route 53"
  type        = string
}

variable "dns_record" {
  description = "Nome do registro DNS"
  type        = string
  default     = "app.store.com"
}
