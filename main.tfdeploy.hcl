store "varset" "this" {
  name     = "enterprise-solution-actualization"
  category = "terraform"
}

deployment "solutions" {
  inputs = {
    github_organization_name = "amiasea"

    gha_id              = store.varset.this.stable.gha_id
    gha_installation_id = store.varset.this.stable.gha_installation_id
    gha_pem_file        = store.varset.this.stable.gha_pem_file

    codeartifact_domain       = store.varset.this.stable.codeartifact_domain
    codeartifact_domain_arn   = store.varset.this.stable.codeartifact_domain_arn
    codeartifact_domain_owner = store.varset.this.stable.codeartifact_domain_owner

    github_oidc_provider_arn = store.varset.this.stable.github_oidc_provider_arn

    solution_definitions_release_tag = "v1.0.3"
  }
}
