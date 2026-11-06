variable "github_organization" {
  description = "GitHub organization that owns the solution definitions repository."
  type        = string
  default     = "amiasea"
}

variable "repository" {
  description = "Repository containing the solution definitions."
  type        = string
  default     = "enterprise-solution-definitions"
}

variable "release_tag" {
  description = "Release tag identifying the solution definitions asset to retrieve."
  type        = string

  validation {
    condition     = length(trimspace(var.release_tag)) > 0
    error_message = "The solution definitions release tag must not be empty."
  }
}