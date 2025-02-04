output "user_arn" {
  value = aws_iam_user.teste_devops.arn
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}