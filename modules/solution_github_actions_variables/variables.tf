
variable "solution_name" {
  description = "Name of the solution whose artifact variables are managed."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9][a-zA-Z0-9-]*$", var.solution_name))
    error_message = "The solution name must start with an alphanumeric character and contain only alphanumeric characters and hyphens."
  }
}

variable "selected_repository_ids" {
  description = "Numeric GitHub repository IDs permitted to access these organization variables."
  type        = list(number)

  validation {
    condition     = length(var.selected_repository_ids) > 0 && length(distinct(var.selected_repository_ids)) == length(var.selected_repository_ids)
    error_message = "Provide a non-empty list of unique numeric GitHub repository IDs."
  }
}

variable "codeartifact_nuget_urls" {
  description = "NuGet feed URLs keyed by aspect option."
  type        = map(string)
  default     = {}
}

variable "codeartifact_npm_urls" {
  description = "npm registry URLs keyed by aspect option."
  type        = map(string)
  default     = {}
}

variable "ecr_repository_urls" {
  description = "ECR repository URLs keyed by aspect option."
  type        = map(string)
  default     = {}
}

variable "artifact_publish_role_arn" {
  description = "AWS IAM role ARN used to publish artifacts."
  type        = string
}

variable "artifact_restore_role_arn" {
  description = "AWS IAM role ARN used to restore artifacts."
  type        = string
}
