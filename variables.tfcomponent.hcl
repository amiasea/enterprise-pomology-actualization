variable "github_organization_name" {
  type = string
}

variable "enterprise_solution_github_organization_name" {
  type = string
}

variable "gha_id" {
  type = string
}

variable "gha_installation_id" {
  type = string
}

variable "enterprise_solution_gha_installation_id" {
  type = string
}

variable "gha_pem_file" {
  type      = string
  sensitive = true
  ephemeral = true
}

///// artifact_access /////

variable "aws_identity_token" {
  description = "JWT identity token from the GitHub Actions workflow that will be used to assume the AWS role."
  type        = string
  ephemeral   = true
}

variable "codeartifact_domain" {
  description = "Name of the shared CodeArtifact domain."
  type        = string
}

variable "codeartifact_domain_arn" {
  description = "ARN of the shared CodeArtifact domain."
  type        = string
}

variable "codeartifact_domain_owner" {
  description = "AWS account ID that owns the CodeArtifact domain."
  type        = string
}

variable "solution_actualization_role_arn" {
  description = "ARN of the AWS role that will be assumed by the GitHub Actions workflow to perform solution actualization."
  type        = string
}

variable "solution_artifact_role_boundary_arn" {
  description = "ARN of the AWS role boundary that will be applied to the solution artifact roles."
  type        = string
}

variable "github_oidc_provider_arn" {
  description = "ARN of the GitHub Actions OIDC provider created by artifact-foundation."
  type        = string
}

//////

variable "solution_definitions_release_tag" {
  description = "Solution definitions release tag"
  type        = string
}

variable "ruleset_enforcement" {
  type    = string
  default = "disabled"
}