component "pomology_definition" {
  source = "./modules/pomology_definition"

  inputs = {
    github_organization = "amiasea"
    repository          = "enterprise-pomology-definitions"
    release_tag         = var.pomology_definitions_release_tag
  }

  providers = {
    github = provider.github.amiasea
  }
}

component "espalier" {
  source  = "app.terraform.io/amiasea/espalier/github"
  version = "1.0.14"

  inputs = {
    pomology = component.pomology_definition.pomology

    repo_name_prefix = split("-", var.pomology_definitions_release_tag)[1]

    github_organization_name = "amiasea-enterprise-orchard"
    github_app_id            = var.gha_id

    ruleset_enforcement = var.ruleset_enforcement

    pomology_definitions_release_tag = var.pomology_definitions_release_tag
  }

  providers = {
    github = provider.github.amiasea_enterprise_orchard
  }
}

locals {
  pomology_aspect_options = sort(tolist(toset(flatten([
    for cordon in values(component.espalier.variety_cordon_repositories) : [
      for variety in values(cordon.varieties) : [
        for leaf in values(variety.leaves) : leaf.option
      ]
    ]
  ]))))

  solution_github_oidc_subject_identifiers = sort(tolist(toset(flatten([
    for cordon_subjects in values(component.espalier.variety_cordon_repositories) : concat(
      [
        "repo:amiasea@${component.espalier.organization.id}/${cordon_subjects.cordon.repository_name}@${cordon_subjects.cordon.repository_id}:*"
      ],
      flatten([
        for variety in values(cordon_subjects.varieties) : [
          for leaf in values(variety.leaves) :
          "repo:amiasea@${component.espalier.organization.id}/${leaf.repository_name}@${leaf.repository_id}:*"
        ]
      ])
    )
  ]))))

  solution_github_repository_ids = sort(tolist(toset(flatten([
    for cordon in values(component.espalier.variety_cordon_repositories) : concat(
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

component "pomology_aspect_options_aws_artifacts" {
  source = "./modules/pomology_aspect_options_aws_artifacts"

  inputs = {
    solution_name = split("-", var.pomology_definitions_release_tag)[1]

    aspect_options = local.pomology_aspect_options

    codeartifact_domain = var.codeartifact_domain
  }

  providers = {
    aws = provider.aws.this
  }
}

component "aws_artifact_publish_access" {
  source = "./modules/aws_artifact_publish_access"

  inputs = {
    role_name = "amiasea-${split("-", var.pomology_definitions_release_tag)[1]}-publish"

    github_oidc_provider_arn = var.github_oidc_provider_arn

    github_oidc_subject_identifiers = local.solution_github_oidc_subject_identifiers

    codeartifact_domain_arn = var.codeartifact_domain_arn

    codeartifact_repository_arns = values(component.pomology_aspect_options_aws_artifacts.package_repository_arns)

    codeartifact_package_arns = values(component.pomology_aspect_options_aws_artifacts.codeartifact_package_arns)

    ecr_repository_arns = values(component.pomology_aspect_options_aws_artifacts.ecr_repository_arns)

    pomology_artifact_role_boundary_arn = var.pomology_artifact_role_boundary_arn
  }

  providers = {
    aws = provider.aws.this
  }
}

component "aws_artifact_restore_access" {
  source = "./modules/aws_artifact_restore_access"

  inputs = {
    role_name = "amiasea-${split("-", var.pomology_definitions_release_tag)[1]}-restore"

    github_oidc_provider_arn = var.github_oidc_provider_arn

    github_oidc_subject_identifiers = local.solution_github_oidc_subject_identifiers

    codeartifact_domain_arn = var.codeartifact_domain_arn

    codeartifact_repository_arns = values(component.pomology_aspect_options_aws_artifacts.package_repository_arns)

    codeartifact_package_arns = values(component.pomology_aspect_options_aws_artifacts.codeartifact_package_arns)

    ecr_repository_arns = values(component.pomology_aspect_options_aws_artifacts.ecr_repository_arns)

    pomology_artifact_role_boundary_arn = var.pomology_artifact_role_boundary_arn
  }

  providers = {
    aws = provider.aws.this
  }
}
