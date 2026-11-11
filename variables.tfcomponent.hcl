variable "github_organization_name" {
  type = string
}

variable "enterprise_orchard_github_organization_name" {
  type = string
}

variable "institutive_resource_group_name" {
  type = string
}

variable "azure_tenant_id" {
  type = string
}

variable "azure_institutive_client_id" {
  type = string
}

variable "azure_institutive_subscription_id" {
  type = string
}

variable "gha_id" {
  type = string
}

variable "gha_installation_id" {
  type = string
}

variable "enterprise_orchard_gha_installation_id" {
  type = string
}

variable "gha_pem_file" {
  type      = string
  sensitive = true
  ephemeral = true
}

///// artifact_access /////

variable "aws_identity_token" {
  description = "JWT identity token that will be used to assume the AWS role."
  type        = string
  ephemeral   = true
}

variable "azure_identity_token" {
  description = "JWT identity token that will be used to assume the UAMI role."
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

variable "pomology_propagation_role_arn" {
  description = "ARN of the AWS role that will be assumed by the GitHub Actions workflow to perform pomology propagation."
  type        = string
}

variable "pomology_artifact_role_boundary_arn" {
  description = "ARN of the AWS role boundary that will be applied to the pomology artifact roles."
  type        = string
}

variable "github_oidc_provider_arn" {
  description = "ARN of the GitHub Actions OIDC provider created by artifact-foundation."
  type        = string
}

//////

variable "pomology_flora_release_tag" {
  description = "Pomology definitions release tag"
  type        = string
}

variable "ruleset_enforcement" {
  type    = string
  default = "disabled"
}