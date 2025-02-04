resource "aws_iam_policy" "custom_policy" {
  name        = "CustomPolicy"
  description = "Política personalizada com permissões específicas"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "s3:ListAllMyBuckets",
          "s3:GetBucketLocation"
        ],
        "Resource": "arn:aws:s3:::project-bucket"
      },
      {
        "Effect": "Allow",
        "Action": [
          "iam:ListAttachedGroupPolicies",
          "iam:ListGroupPolicies",
          "iam:GetGroupPolicy"
        ],
        "Resource": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:group/DevOpsGroup"
      },
      {
        "Effect": "Allow",
        "Action": [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ],
        "Resource": "arn:aws:secretsmanager:us-east-1:${data.aws_caller_identity.current.account_id}:secret:*"
      },
      {
        "Effect": "Allow",
        "Action": [
          "iam:ListAttachedUserPolicies",
          "iam:ListUserPolicies",
          "iam:GetUserPolicy",
          "iam:ListGroupsForUser"
        ],
        "Resource": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/teste-devops"
      },
      {
        "Effect": "Allow",
        "Action": [
          "iam:PassRole"
        ],
        "Resource": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/TerraformExecutionRole"
      }
    ]
  })
}