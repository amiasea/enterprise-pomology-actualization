required_providers {
  github = {
    source  = "integrations/github"
    version = "~> 6.13.0"
  }

  aws = {
    source  = "hashicorp/aws"
    version = "~> 6.70.0"
  }
}

provider "github" "this" {
  config {
    owner = var.github_organization_name

    app_auth {
      id              = var.gha_id
      installation_id = var.gha_installation_id
      pem_file        = var.gha_pem_file
    }
  }
}

provider "aws" "this" {
  config {
    region = "us-east-1"
    profile = "amiasea"
  }
}