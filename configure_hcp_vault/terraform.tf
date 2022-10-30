terraform {
  required_providers {
    hcp = {
      source  = "hashicorp/hcp"
      version = ">=0.41.0"
    }
  }

  cloud {
    organization = "demo-lab-hashicorp"

    workspaces {
      name = "oidc-vault-cluster-hcp"
    }
  }
}

