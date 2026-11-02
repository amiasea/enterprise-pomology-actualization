component "solution_definitions" {
  source = "./modules/solution_definitions"

  inputs = {
    github_organization = "amiasea"
    repository          = "enterprise-solution-definitions"
    release_tag         = var.solution_definitions_release_tag
  }

  providers = {
    github = provider.github.this
  }
}

component "espalier" {
  source  = "app.terraform.io/amiasea/espalier/github"
  version = "1.0.0"

  for_each = component.solution_definitions.pomologies

  inputs = {
    pomology         = each.value
    repo_name_prefix = each.key

    github_organization_name = var.github_organization_name
    github_app_id            = var.gha_id
  }

  providers = {
    github = provider.github.this
  }
}

locals {
  solution_aspect_options = {
    for solution_name in keys(component.solution_definitions.pomologies) :
    solution_name => sort(tolist(toset(flatten([
      for cordon in values(component.espalier[solution_name].variety_cordon_repositories) : [
        for variety in values(cordon.varieties) : [
          for leaf in values(variety.leaves) : leaf.option
        ]
      ]
    ]))))
  }

  solution_github_oidc_subject_identifiers = {
    for solution_name in keys(component.solution_definitions.pomologies) :
    solution_name => sort(tolist(toset(flatten([
      for cordon_subjects in values(component.espalier[solution_name].variety_cordon_repositories) : concat(
        [
          "repo:amiasea@${component.espalier[solution_name].organization.id}/${cordon_subjects.cordon.repository_name}@${cordon_subjects.cordon.repository_id}:*"
        ],
        flatten([
          for variety in values(cordon_subjects.varieties) : [
            for leaf in values(variety.leaves) :
            "repo:amiasea@${component.espalier[solution_name].organization.id}/${leaf.repository_name}@${leaf.repository_id}:*"
          ]
        ])
      )
    ]))))
  }

  solution_github_repository_ids = {
    for solution_name in keys(component.solution_definitions.pomologies) :
    solution_name => sort(tolist(toset(flatten([
      for cordon in values(component.espalier[solution_name].variety_cordon_repositories) : concat(
        [cordon.cordon.repository_id],
        [
          for leaf in flatten([
            for variety in values(cordon.varieties) :
            values(variety.leaves)
          ]) : leaf.repository_id
        ]
      )
    ]))))
  }
}

component "solution_aspect_option_aws_artifacts" {
  source   = "./modules/solution_aspect_options_aws_artifacts"
  for_each = component.solution_definitions.pomologies

  inputs = {
    solution_name = each.key

    aspect_options = local.solution_aspect_options[each.key]

    codeartifact_domain = var.codeartifact_domain
  }

  providers = {
    aws = provider.aws.this
  }
}

component "aws_artifact_publish_access" {
  source   = "./modules/aws_artifact_publish_access"
  for_each = component.solution_aspect_options_aws_artifacts

  inputs = {
    role_name = "amiasea-${each.key}-publish"

    github_oidc_provider_arn = var.github_oidc_provider_arn

    github_oidc_subject_identifiers = local.solution_github_oidc_subject_identifiers[each.key]

    codeartifact_domain_arn = var.codeartifact_domain_arn

    codeartifact_repository_arns = values(each.value.package_repository_arns)

    codeartifact_package_arns = values(each.value.codeartifact_package_arns)

    ecr_repository_arns = values(each.value.ecr_repository_arns)
  }

  providers = {
    aws = provider.aws.this
  }
}

component "aws_artifact_restore_access" {
  source   = "./modules/aws_artifact_restore_access"
  for_each = component.solution_aspect_options_aws_artifacts

  inputs = {
    role_name = "amiasea-${each.key}-restore"

    github_oidc_provider_arn = var.github_oidc_provider_arn

    github_oidc_subject_identifiers = local.solution_github_oidc_subject_identifiers[each.key]

    codeartifact_domain_arn = var.codeartifact_domain_arn

    codeartifact_repository_arns = values(each.value.package_repository_arns)

    codeartifact_package_arns = values(each.value.codeartifact_package_arns)

    ecr_repository_arns = values(each.value.ecr_repository_arns)
  }

  providers = {
    aws = provider.aws.this
  }
}
