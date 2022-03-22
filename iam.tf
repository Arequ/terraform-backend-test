# configure IAM users/roles

data "aws_iam_policy_document" "backend-policy-data" {
  statement {
    actions   = ["s3:ListBucket"]
    resources = ["${aws_s3_bucket.tf-state-bucket.arn}"]
    effect = "Allow"
  }
  statement {
    actions   = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
    resources = ["${aws_s3_bucket.tf-state-bucket.arn}/backend_inception/*"]
    effect = "Allow"
  }
  statement {
    actions   = ["dynamodb:GetItem", "dynamodb:PutItem", "dynamodb:DeleteItem"]
    resources = ["${aws_s3_bucket.tf-state-bucket.arn}/backend_inception/*"]
    effect = "Allow"
  }
}

resource "aws_iam_user" "tf-user" {
    name  = var.username
    path  = "/system/"
}

resource "aws_iam_access_key" "tf-user-key" {
    user  = var.username
}

resource "aws_iam_policy" "tf-backend-policy" {
    name        = "tf-user-policy"
    path        = "/"
    description = "Policy to configure s3 backend for TF"
    policy      = data.aws_iam_policy_document.backend-policy-data.json
}

resource "aws_iam_user_policy_attachment" "tf-attach" {
  user       = aws_iam_user.tf-user.name
  policy_arn = aws_iam_policy.tf-backend-policy.arn
}

output "rendered_policy" {
    value = data.aws_iam_policy_document.backend-policy-data.json
}

