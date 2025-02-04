resource "null_resource" "cleanup" {
  provisioner "local-exec" {
    command = "terraform destroy -auto-approve -target=aws_iam_user.teste_devops -target=aws_iam_group.devops_group -target=aws_iam_policy.custom_policy"
  }
}