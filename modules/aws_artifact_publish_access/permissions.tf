data "aws_iam_policy_document" "artifact_publish" {
  statement {
    sid       = "GetCodeArtifactAuthorizationToken"
    effect    = "Allow"
    actions   = ["codeartifact:GetAuthorizationToken"]
    resources = [var.codeartifact_domain_arn]
  }

  statement {
    sid       = "GetCodeArtifactServiceBearerToken"
    effect    = "Allow"
    actions   = ["sts:GetServiceBearerToken"]
    resources = ["*"]

    condition {
      test     = "StringEquals"
      variable = "sts:AWSServiceName"
      values   = ["codeartifact.amazonaws.com"]
    }
  }

  statement {
    sid    = "AccessCodeArtifactRepositories"
    effect = "Allow"

    actions = [
      "codeartifact:GetRepositoryEndpoint",
      "codeartifact:ReadFromRepository",
    ]

    resources = var.codeartifact_repository_arns
  }

  statement {
    sid    = "PublishPackageVersions"
    effect = "Allow"

    actions = [
      "codeartifact:PublishPackageVersion",
      "codeartifact:PutPackageMetadata",
    ]

    resources = var.codeartifact_package_arns
  }

  statement {
    sid       = "GetECRAuthorizationToken"
    effect    = "Allow"
    actions   = ["ecr:GetAuthorizationToken"]
    resources = ["*"]
  }

  statement {
    sid    = "PublishAndVerifyECRImages"
    effect = "Allow"

    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:CompleteLayerUpload",
      "ecr:DescribeImages",
      "ecr:DescribeRepositories",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:UploadLayerPart",
    ]

    resources = var.ecr_repository_arns
  }
}

resource "aws_iam_role_policy" "artifact_publish" {
  name   = "publish-enterprise-artifacts"
  role   = aws_iam_role.this.id
  policy = data.aws_iam_policy_document.artifact_publish.json
}