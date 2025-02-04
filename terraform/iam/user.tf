data "aws_caller_identity" "current" {}

resource "aws_iam_user" "teste_devops" {
  name          = "teste-devops"
  force_destroy = true
}

resource "aws_iam_user_group_membership" "teste_devops_membership" {
  user   = aws_iam_user.teste_devops.name
  groups = [aws_iam_group.devops_group.name]
}
