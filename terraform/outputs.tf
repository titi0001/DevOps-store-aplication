output "rds_endpoint" {
  description = "Endpoint do banco de dados PostgreSQL"
  value       = aws_db_instance.postgres.endpoint
}

output "store_db_user" {
  description = "Usuário do banco de dados PostgreSQL"
  value       = local.db_credentials.username
  sensitive   = true
}

output "store_db_password" {
  description = "Senha do banco de dados PostgreSQL"
  value       = local.db_credentials.password
  sensitive   = true
}

output "store_db_name" {
  description = "Nome do banco de dados PostgreSQL"
  value       = local.db_credentials.db_name
}

output "ecs_cluster_name" {
  description = "Nome do Cluster ECS"
  value       = aws_ecs_cluster.store_cluster.name
}

output "ecs_service_name" {
  description = "Nome do Serviço ECS"
  value       = aws_ecs_service.store_service.name
}

output "iam_role_arn" {
  description = "ARN da Role de Execução do ECS"
  value       = aws_iam_role.ecs_task_execution_role.arn
}

output "route53_cname" {
  description = "Registro CNAME no Route 53"
  value       = aws_route53_record.store_cname.fqdn
}

output "route53_zone_id" {
  description = "ID da zona hospedada do Route 53"
  value       = aws_route53_zone.store_zone.zone_id
}

output "user_arn" {
  value = module.iam.user_arn
}

output "account_id" {
  value = module.iam.account_id
}