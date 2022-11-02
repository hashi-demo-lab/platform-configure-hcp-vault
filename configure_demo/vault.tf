provider "vault" {
  address = var.vault_server_url
}

# Create a KV secrets engine
resource "vault_mount" "app" {
  path        = var.kv_secrets_path
  type        = "kv"
  options     = { version = "2" }
  description = "KV mount for OIDC demo"
}

# Create a secret in the KV engine

resource "vault_kv_secret_v2" "app" {
  mount = vault_mount.app.path
  name  = "some_secret"
  data_json = jsonencode(
    {
      some_secret1 = "test1",
      some_secret2 = "test2"
    }
  )
}

# Create a policy granting the GitHub repo access to the KV engine
resource "vault_policy" "app" {
  name = "github-actions-oidc"

  policy = <<EOT
path "${vault_kv_secret_v2.app.path}" {
  capabilities = ["list","read"]
}
EOT
}

# Create the JWT auth method to use GitHub
resource "vault_jwt_auth_backend" "jwt" {
  description        = "JWT Backend for GitHub Actions"
  path               = "jwt"
  oidc_discovery_url = "https://token.actions.githubusercontent.com"
  bound_issuer       = "https://token.actions.githubusercontent.com"
}

# Create the JWT role tied to the repo
resource "vault_jwt_auth_backend_role" "example" {
  backend           = vault_jwt_auth_backend.jwt.path
  role_name         = "github-actions-role"
  token_policies    = [vault_policy.app.name]
  token_max_ttl     = "3600"
  bound_audiences   = ["https://github.com/${var.github_organization}"]
  bound_claims_type = "string"
  bound_subject     = "repo:${var.github_organization}/${var.github_repository}:ref:refs/heads/main"
  user_claim        = "actor"
  role_type         = "jwt"
}