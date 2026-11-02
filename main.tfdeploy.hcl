store "varset" "this" {
  name = "solution-actualization"
  category = "terraform"
}

deployment "solutions" {
  inputs = {
    github_organization_name = "amiasea"
    github_organization_id = store.varset.this.github_organization_id

    gha_id = store.varset.this.stable.gha_id
    gha_installation_id = store.varset.this.stable.gha_installation_id
    gha_pem_file = store.varset.this.gha_pem_file

    codeartifact_domain = store.varset.this.codeartifact_domain
    codeartifact_domain_arn = store.varset.this.codeartifact_domain_arn
    codeartifact_domain_owner = store.varset.this.codeartifact_domain_owner

    github_oidc_provider_arn = store.varset.this.github_oidc_provider_arn

    solution_definitions_release_tag = "v1.0.3"
  }
}