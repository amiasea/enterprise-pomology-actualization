locals {
  artifact_repository_names = {
    for aspect_option in var.aspect_options :
    aspect_option => "amiasea-${var.pomology_name}-${aspect_option}"
  }
}

resource "aws_ecr_repository" "ecr_repository" {
  for_each = local.artifact_repository_names

  name                 = each.value
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }
}

resource "aws_codeartifact_repository" "package_repository" {
  for_each = local.artifact_repository_names

  domain      = var.codeartifact_domain
  repository  = each.value
  description = "Private packages for ${var.pomology_name} aspect option ${each.key}."
}