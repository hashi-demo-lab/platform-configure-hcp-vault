terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "~>3.0"
    }

    github = {
      source  = "integrations/github"
      version = "~> 4.0"
    }
  }

  cloud {
    organization = "demo-lab-hashicorp"

    workspaces {
      name = "platform-oidc-github-demo"
    }
  }
}

