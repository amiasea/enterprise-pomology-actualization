variable "role_name" {
  description = "Name of the IAM role used to publish enterprise artifacts."
  type        = string
  default     = "amiasea-enterprise-publish"
}

variable "github_oidc_provider_arn" {
  description = "ARN of the IAM OIDC provider for GitHub Actions."
  type        = string
}

variable "github_oidc_subject_identifiers" {
  description = "Complete GitHub Actions OIDC subject patterns permitted to assume the publish role."
  type        = list(string)

  validation {
    condition     = length(var.github_oidc_subject_identifiers) > 0
    error_message = "At least one GitHub Actions OIDC subject identifier must be supplied."
  }
}

variable "codeartifact_domain_arn" {
  description = "ARN of the shared CodeArtifact domain."
  type        = string
}

variable "codeartifact_repository_arns" {
  description = "ARNs of CodeArtifact repositories where packages may be published."
  type        = list(string)

  validation {
    condition     = length(var.codeartifact_repository_arns) > 0
    error_message = "At least one CodeArtifact repository ARN must be supplied."
  }
}

variable "codeartifact_package_arns" {
  description = "Resource ARNs for packages within the permitted CodeArtifact repositories."
  type        = list(string)

  validation {
    condition     = length(var.codeartifact_package_arns) > 0
    error_message = "At least one CodeArtifact package ARN pattern must be supplied."
  }
}

variable "ecr_repository_arns" {
  description = "ARNs of ECR repositories where images may be published."
  type        = list(string)

  validation {
    condition     = length(var.ecr_repository_arns) > 0
    error_message = "At least one ECR repository ARN must be supplied."
  }
}

variable "pomology_artifact_role_boundary_arn" {
  description = "ARN of the AWS role boundary that will be applied to the solution artifact roles."
  type        = string
}