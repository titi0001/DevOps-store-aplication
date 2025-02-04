resource "aws_backup_vault" "store_backup_vault" {
  name = "store-backup-vault"
}

resource "aws_backup_plan" "store_backup_plan" {
  name = "store-backup-plan"

  rule {
    rule_name         = "daily-backup"
    target_vault_name = aws_backup_vault.store_backup_vault.name
    schedule          = "cron(0 3 * * ? *)" # Backup diário às 03:00 UTC
    lifecycle {
      delete_after = 30 # Mantém o backup por 30 dias
    }
  }
}

resource "aws_backup_selection" "store_backup_selection" {
  name         = "store-backup-selection"
  iam_role_arn = aws_iam_role.backup_role.arn

  plan_id = aws_backup_plan.store_backup_plan.id

  resources = [
    aws_db_instance.postgres.arn
  ]
}

resource "aws_iam_role" "backup_role" {
  name = "AWSBackupDefaultServiceRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "backup.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "backup_role_policy" {
  role       = aws_iam_role.backup_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}
