data "aws_secretsmanager_secret" "db_credentials" {
  name = "devops-store-db-credentials"
}

data "aws_secretsmanager_secret_version" "db_credentials_version" {
  secret_id = data.aws_secretsmanager_secret.db_credentials.id
}

locals {
  db_credentials = jsondecode(data.aws_secretsmanager_secret_version.db_credentials_version.secret_string)
}

resource "aws_db_instance" "postgres" {
  allocated_storage       = 20
  engine                  = "postgres"
  instance_class          = "db.t3.micro"
  db_name                 = local.db_credentials.db_name
  username                = local.db_credentials.username
  password                = local.db_credentials.password
  publicly_accessible     = true
  vpc_security_group_ids  = [aws_security_group.store_sg.id]
  skip_final_snapshot     = false
  backup_retention_period = 30
  backup_window           = "03:00-04:00"
}
