data "aws_iam_policy_document" "artifact_restore" {
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
      "codeartifact:DescribeRepository",
      "codeartifact:GetRepositoryEndpoint",
      "codeartifact:ListPackages",
      "codeartifact:ReadFromRepository",
    ]

    resources = var.codeartifact_repository_arns
  }

  statement {
    sid    = "ReadCodeArtifactPackageVersions"
    effect = "Allow"

    actions = [
      "codeartifact:DescribePackageVersion",
      "codeartifact:GetPackageVersionReadme",
      "codeartifact:ListPackageVersionAssets",
      "codeartifact:ListPackageVersionDependencies",
      "codeartifact:ListPackageVersions",
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
    sid    = "RestoreECRImages"
    effect = "Allow"

    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:DescribeImages",
      "ecr:DescribeRepositories",
      "ecr:GetDownloadUrlForLayer",
    ]

    resources = var.ecr_repository_arns
  }
}

resource "aws_iam_role_policy" "artifact_restore" {
  name   = "restore-enterprise-artifacts"
  role   = aws_iam_role.this.id
  policy = data.aws_iam_policy_document.artifact_restore.json
}