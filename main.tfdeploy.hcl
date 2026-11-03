identity_token "aws" {
  audience = ["aws.workload.identity"]
}

store "varset" "this" {
  name     = "enterprise-solution-actualization"
  category = "terraform"
}

deployment "solutions" {
  destroy = true
  inputs = {
    github_organization_name = "amiasea"

    gha_id              = store.varset.this.stable.gha_id
    gha_installation_id = store.varset.this.stable.gha_installation_id
    gha_pem_file        = store.varset.this.gha_pem_file

    aws_identity_token = identity_token.aws.jwt

    codeartifact_domain                 = store.varset.this.stable.codeartifact_domain
    codeartifact_domain_arn             = store.varset.this.stable.codeartifact_domain_arn
    codeartifact_domain_owner           = store.varset.this.stable.codeartifact_domain_owner
    solution_actualization_role_arn     = store.varset.this.stable.solution_actualization_role_arn
    solution_artifact_role_boundary_arn = store.varset.this.stable.solution_artifact_role_boundary_arn

    github_oidc_provider_arn = store.varset.this.stable.github_oidc_provider_arn

    solution_definitions_release_tag = "v1.0.4"
  }
}