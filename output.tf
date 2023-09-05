output "demo-commands" {
  value = [
    "vault read ${var.aws_path}/creds/${vault_aws_secret_backend_role.iam_admin.name}",
    "aws iam list-user-policies --user-name tykaburagi",
    "aws s3 ls"
    ]
}