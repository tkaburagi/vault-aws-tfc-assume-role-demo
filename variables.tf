variable "region" {
  default = "ap-northeast-1"
}

variable "aws_path" {
  default = "aws"
}

variable "tfc_org" {
  default = "tkaburagi"
}

variable "vault_addr" {}

variable "vault_ns" {
  default = "admin"
}

variable "tfc_vault_backed_aws_auth_type" {
  default = "assumed_role"
}