resource "tfe_project" "demo-pj" {
  organization = var.tfc_org
  name         = "demo-pj"
}

resource "tfe_workspace" "demo-ws" {
  name         = random_pet.pet.id
  organization = var.tfc_org
  project_id = tfe_project.demo-pj.id
}

resource "tfe_variable" "dcp_1" {
  key             = "TFC_VAULT_PROVIDER_AUTH"
  value           = "true"
  category        = "env"
  workspace_id = tfe_workspace.demo-ws.id
}

resource "tfe_variable" "dcp_2" {
  key             = "TFC_VAULT_ADDR"
  value           = var.vault_addr
  category        = "env"
  workspace_id = tfe_workspace.demo-ws.id
}
resource "tfe_variable" "dcp_3" {
  key             = "TFC_VAULT_RUN_ROLE"
  value           = vault_jwt_auth_backend_role.tfc_all.role_name
  category        = "env"
  workspace_id = tfe_workspace.demo-ws.id
}

resource "tfe_variable" "dcp_4" {
  key             = "TFC_VAULT_BACKED_AWS_AUTH"
  value           = "true"
  category        = "env"
  workspace_id = tfe_workspace.demo-ws.id
}

resource "tfe_variable" "dcp_5" {
  key             = "TFC_VAULT_BACKED_AWS_AUTH_TYPE"
  value           = var.tfc_vault_backed_aws_auth_type
  category        = "env"
  workspace_id = tfe_workspace.demo-ws.id
}

resource "tfe_variable" "dcp_6" {
  key             = "TFC_VAULT_BACKED_AWS_RUN_VAULT_ROLE"
  value           = vault_aws_secret_backend_role.infra_deployer.name
  category        = "env"
  workspace_id = tfe_workspace.demo-ws.id
}

resource "tfe_variable" "dcp_7" {
  key             = "TFC_VAULT_NAMESPACE"
  value           = var.vault_ns
  category        = "env"
  workspace_id = tfe_workspace.demo-ws.id
}

resource "tfe_variable" "dcp_8" {
  key             = "TFC_VAULT_BACKED_AWS_RUN_ROLE_ARN"
  value           = "arn:aws:iam::643529556251:role/infra-deployer"
  category        = "env"
  workspace_id = tfe_workspace.demo-ws.id
}