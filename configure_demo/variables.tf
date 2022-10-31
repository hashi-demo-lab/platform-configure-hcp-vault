variable "vault_server_url" {
  type        = string
  description = "(Required) The URL of the Vault server"
  default     = "https://oidc-demo-public-vault-63fb4bf9.b702897f.z1.hashicorp.cloud:8200"
}

variable "github_organization" {
  type        = string
  description = "(Required) The GitHub organization or username for the JWT authentication role."
  default     = "hashicorp-demo-lab"
}

variable "github_repository" {
  type        = string
  description = "(Required) The GitHub repository for the JWT authentication role."
  default     = "platform-configure-hcp-vault"
}

