resource "aws_iam_role" "this" {
  name               = var.role_name
  description        = "Allows approved Amiasea GitHub Actions workflows to restore enterprise artifacts."
  assume_role_policy = data.aws_iam_policy_document.role_trust.json
}