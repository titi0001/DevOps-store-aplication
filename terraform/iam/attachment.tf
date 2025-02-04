resource "aws_iam_user_policy_attachment" "attach_custom_policy_to_user" {
  user       = aws_iam_user.teste_devops.name
  policy_arn = aws_iam_policy.custom_policy.arn
}