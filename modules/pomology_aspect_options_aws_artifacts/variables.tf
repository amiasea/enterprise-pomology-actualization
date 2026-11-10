variable "pomology_name" {
  description = "Codename of the enterprise pomology being propagated."
  type        = string
}

variable "aspect_options" {
  description = "Unique aspect option codenames for which artifact repositories are provisioned."
  type        = list(string)

  validation {
    condition     = length(var.aspect_options) > 0
    error_message = "At least one aspect option must be supplied."
  }

  validation {
    condition     = length(var.aspect_options) == length(distinct(var.aspect_options))
    error_message = "Aspect option codenames must be unique."
  }

  validation {
    condition = alltrue([
      for codename in var.aspect_options :
      can(regex("^[a-z0-9][a-z0-9-]*$", codename))
    ])
    error_message = "Aspect option codenames must contain only lowercase letters, digits, and hyphens, and must start with a letter or digit."
  }
}

variable "codeartifact_domain" {
  description = "Name of the shared AWS CodeArtifact domain."
  type        = string
}