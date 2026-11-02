
locals {
  solution_prefix = "AMI_${upper(replace(var.solution_name, "-", "_"))}"

  organization_variables = merge(
    {
      for option, url in var.codeartifact_nuget_urls :
      "codeartifact_nuget_${option}" => {
        name  = "${local.solution_prefix}_CODEARTIFACT_${upper(replace(option, "-", "_"))}_NUGET_URL"
        value = url
      }
    },
    {
      for option, url in var.codeartifact_npm_urls :
      "codeartifact_npm_${option}" => {
        name  = "${local.solution_prefix}_CODEARTIFACT_${upper(replace(option, "-", "_"))}_NPM_URL"
        value = url
      }
    },
    {
      for option, url in var.ecr_repository_urls :
      "ecr_repository_${option}" => {
        name  = "${local.solution_prefix}_ECR_${upper(replace(option, "-", "_"))}_REPOSITORY_URL"
        value = url
      }
    },
    {
      artifact_publish_role_arn = {
        name  = "${local.solution_prefix}_ARTIFACT_PUBLISH_ROLE_ARN"
        value = var.artifact_publish_role_arn
      }

      artifact_restore_role_arn = {
        name  = "${local.solution_prefix}_ARTIFACT_RESTORE_ROLE_ARN"
        value = var.artifact_restore_role_arn
      }
    }
  )
}

resource "github_actions_organization_variable" "this" {
  for_each = local.organization_variables

  variable_name           = each.value.name
  value                   = each.value.value
  visibility              = "selected"
  selected_repository_ids = var.selected_repository_ids
}
