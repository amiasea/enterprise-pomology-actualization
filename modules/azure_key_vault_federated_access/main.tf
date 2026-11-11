data "azurerm_user_assigned_identity" "enterprise_workload_orchard" {
  name                = "amiasea-enterprise-workload-orchard"
  resource_group_name = var.azure_institutive_resource_group_name
}

# data "azurerm_user_assigned_identity" "enterprise_workload_institutive" {
#   name                = "amiasea-enterprise-workload-institutive"
#   resource_group_name = var.azure_institutive_resource_group_name
# }

data "github_repositories" "orchard_repositories" {
  query           = "org:amiasea-enterprise-orchard archived:false"
  include_repo_id = true
}

data "github_organization" "amiasea_enterprise_orchard" {
  name = var.enterprise_orchard_github_organization_name
}

locals {
  enterprise_orchard_repositories = {
    for index, name in data.github_repositories.orchard_repositories.names :
    tostring(data.github_repositories.orchard_repositories.repo_ids[index]) => {
      name          = name
      repository_id = data.github_repositories.orchard_repositories.repo_ids[index]
    }
    if startswith(name, "${var.repo_name_prefix}-")
  }

  enterprise_orchard_federated_credential_subject_identifiers = {
    for repository_id, repository in local.enterprise_orchard_repositories :
    repository_id => "repo:${var.enterprise_orchard_github_organization_name}@${data.github_organization.amiasea_enterprise_orchard.id}/${repository.name}@${repository.repository_id}:pull_request"
  }
}

resource "azurerm_federated_identity_credential" "enterprise_workload_orchard" {
  for_each = local.enterprise_orchard_federated_credential_subject_identifiers

  user_assigned_identity_id = data.azurerm_user_assigned_identity.enterprise_workload_orchard.id

  name     = "github-${substr(sha256(each.value), 0, 16)}"
  audience = ["api://AzureADTokenExchange"]
  issuer   = "https://token.actions.githubusercontent.com"
  subject  = each.value
}