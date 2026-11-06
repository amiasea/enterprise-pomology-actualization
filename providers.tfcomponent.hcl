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

provider "github" "amiasea" {
  config {
    owner = var.github_organization_name

    app_auth {
      id              = var.gha_id
      installation_id = var.gha_installation_id
      pem_file        = var.gha_pem_file
    }
  }
}

provider "github" "amiasea_enterprise_solution" {
  config {
    owner = var.enterprise_solution_github_organization_name

    app_auth {
      id              = var.gha_id
      installation_id = var.enterprise_solution_gha_installation_id
      pem_file        = var.gha_pem_file
    }
  }
}

provider "aws" "this" {
  config {
    region = "us-east-1"

    assume_role_with_web_identity {
      role_arn           = var.solution_actualization_role_arn
      web_identity_token = var.aws_identity_token
    }
  }
}