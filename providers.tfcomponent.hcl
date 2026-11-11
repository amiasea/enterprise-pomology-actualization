required_providers {
  github = {
    source  = "integrations/github"
    version = "~> 6.13.0"
  }

  aws = {
    source  = "hashicorp/aws"
    version = "~> 6.70.0"
  }

  azurerm = {
    source  = "hashicorp/azurerm"
    version = "~> 5.7.0"
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

provider "github" "amiasea_enterprise_orchard" {
  config {
    owner = var.enterprise_orchard_github_organization_name

    app_auth {
      id              = var.gha_id
      installation_id = var.enterprise_orchard_gha_installation_id
      pem_file        = var.gha_pem_file
    }
  }
}

provider "aws" "this" {
  config {
    region = "us-east-1"

    assume_role_with_web_identity {
      role_arn           = var.pomology_propagation_role_arn
      web_identity_token = var.aws_identity_token
    }
  }
}

provider "azurerm" "this" {
  config {
    features {}

    tenant_id       = var.azure_tenant_id
    client_id       = var.azure_orchard_client_id
    subscription_id = var.azure_institutive_subscription_id

    use_oidc   = true
    oidc_token = var.azure_identity_token
  }
}
