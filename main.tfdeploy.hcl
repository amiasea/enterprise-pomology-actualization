identity_token "aws" {
  audience = ["aws.workload.identity"]
}

identity_token "azure" {
  audience = ["api://AzureADTokenExchange"]
}

store "varset" "this" {
  name     = "enterprise-pomology-propagation"
  category = "terraform"
}

deployment "pomology" {
  inputs = {
    github_organization_name                    = "amiasea"
    enterprise_orchard_github_organization_name = "amiasea-enterprise-orchard"
    institutive_resource_group_name             = store.varset.this.stable.institutive_resource_group_name

    azure_tenant_id                   = store.varset.this.stable.azure_tenant_id
    azure_institutive_client_id       = store.varset.this.stable.azure_institutive_client_id
    azure_institutive_subscription_id = store.varset.this.stable.azure_institutive_subscription_id

    gha_id                                 = store.varset.this.stable.gha_id
    gha_installation_id                    = store.varset.this.stable.gha_installation_id
    enterprise_orchard_gha_installation_id = store.varset.this.stable.enterprise_orchard_gha_installation_id
    gha_pem_file                           = store.varset.this.gha_pem_file

    aws_identity_token   = identity_token.aws.jwt
    azure_identity_token = identity_token.azure.jwt

    codeartifact_domain                 = store.varset.this.stable.codeartifact_domain
    codeartifact_domain_arn             = store.varset.this.stable.codeartifact_domain_arn
    codeartifact_domain_owner           = store.varset.this.stable.codeartifact_domain_owner
    pomology_propagation_role_arn       = store.varset.this.stable.pomology_propagation_role_arn
    pomology_artifact_role_boundary_arn = store.varset.this.stable.pomology_artifact_role_boundary_arn

    github_oidc_provider_arn = store.varset.this.stable.github_oidc_provider_arn

    pomology_flora_release_tag = store.varset.this.stable.pomology_flora_release_tag

    ruleset_enforcement = "disabled"
  }
}

deployment "pomology_testing" {
  inputs = {
    github_organization_name                    = "amiasea"
    enterprise_orchard_github_organization_name = "amiasea-enterprise-orchard"
    institutive_resource_group_name             = store.varset.this.stable.institutive_resource_group_name

    azure_tenant_id                   = store.varset.this.stable.azure_tenant_id
    azure_institutive_client_id       = store.varset.this.stable.azure_institutive_client_id
    azure_institutive_subscription_id = store.varset.this.stable.azure_institutive_subscription_id

    gha_id                                 = store.varset.this.stable.gha_id
    gha_installation_id                    = store.varset.this.stable.gha_installation_id
    enterprise_orchard_gha_installation_id = store.varset.this.stable.enterprise_orchard_gha_installation_id
    gha_pem_file                           = store.varset.this.gha_pem_file

    aws_identity_token   = identity_token.aws.jwt
    azure_identity_token = identity_token.azure.jwt

    codeartifact_domain                 = store.varset.this.stable.codeartifact_domain
    codeartifact_domain_arn             = store.varset.this.stable.codeartifact_domain_arn
    codeartifact_domain_owner           = store.varset.this.stable.codeartifact_domain_owner
    pomology_propagation_role_arn       = store.varset.this.stable.pomology_propagation_role_arn
    pomology_artifact_role_boundary_arn = store.varset.this.stable.pomology_artifact_role_boundary_arn

    github_oidc_provider_arn = store.varset.this.stable.github_oidc_provider_arn

    pomology_flora_release_tag = "v1.0.1-testing"

    ruleset_enforcement = "disabled"
  }
}
