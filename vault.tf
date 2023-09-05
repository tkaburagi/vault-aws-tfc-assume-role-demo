resource "vault_aws_secret_backend_role" "iam_admin" {
  backend         = var.aws_path
  credential_type = "assumed_role"
  role_arns       = ["arn:aws:iam::643529556251:role/iam-admin"]
  name            = "iam_admin"
}

resource "vault_aws_secret_backend_role" "infra_deployer" {
  backend         = var.aws_path
  credential_type = "assumed_role"
  role_arns       = ["arn:aws:iam::643529556251:role/infra-deployer"]
  name            = "infra_deployer"
}

resource "vault_policy" "infra_deployer" {
  name   = "infra_deployer"
  policy = <<EOT
  path "auth/token/lookup-self" {
    capabilities = ["read"]
  }

  path "auth/token/renew-self" {
      capabilities = ["update"]
  }

  path "auth/token/revoke-self" {
      capabilities = ["update"]
  }
  path "${var.aws_path}/sts/${vault_aws_secret_backend_role.infra_deployer.name}" {
      capabilities = ["read"]
  }
  EOT
}

resource "vault_policy" "aws_iam_admin" {
  name   = "aws_iam_admin"
  policy = <<EOT
    path "${var.aws_path}/creds/${vault_aws_secret_backend_role.iam_admin.name}" {
      capabilities = ["read"]
    }
  EOT
}

resource "vault_jwt_auth_backend" "jwt" {
  oidc_discovery_url = "https://app.terraform.io"
  bound_issuer       = "https://app.terraform.io"
}

resource "vault_jwt_auth_backend_role" "tfc_all" {
  role_name         = "tfc-role"
  backend           = vault_jwt_auth_backend.jwt.path
  token_policies    = ["default", "infra_deployer"]
  bound_audiences   = ["vault.workload.identity"]
  bound_claims_type = "glob"
  bound_claims = {
    "sub" : "organization:${var.tfc_org}:project:${tfe_project.demo-pj.name}:workspace:${tfe_workspace.demo-ws.name}:run_phase:*"
  }
  user_claim = "terraform_full_workspace"
  role_type  = "jwt"
  token_ttl  = 180
}