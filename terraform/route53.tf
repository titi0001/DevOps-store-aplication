# Criação da zona hospedada no Route 53
resource "aws_route53_zone" "store_zone" {
  name = "example.com" # Domínio reservado para fins de teste e documentação
}

# Criação do registro CNAME na zona hospedada
resource "aws_route53_record" "store_cname" {
  zone_id = aws_route53_zone.store_zone.zone_id
  name    = "app"
  type    = "CNAME"
  ttl     = 300
  records = [aws_lb.store_lb.dns_name]
}

# Armazenar o Zone ID no AWS Secrets Manager
resource "aws_secretsmanager_secret" "route53_zone_secret" {
  name = "devops-store-route53-zone-id"
}

resource "aws_secretsmanager_secret_version" "route53_zone_secret_version" {
  secret_id     = aws_secretsmanager_secret.route53_zone_secret.id
  secret_string = jsonencode({ zone_id = aws_route53_zone.store_zone.zone_id })
}
