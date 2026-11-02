variable "github_organization_name" {
  type = string
  default = "amiasea"
}

variable "gha_id" {
  type = string
}

variable "gha_installation_id" {
  type = string
}

variable "gha_pem_file" {
  type = string
}

///// artifact_access /////

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

variable "github_oidc_provider_arn" {
  description = "ARN of the GitHub Actions OIDC provider created by artifact-foundation."
  type        = string
}

//////

variable "solution_definitions_release_tag" {
  description = "Solution definitions release tag"
  type = string
}