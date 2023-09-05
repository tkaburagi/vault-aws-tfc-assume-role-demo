terraform {
  cloud {
    organization = "tkaburagi"

    workspaces {
      name = "vast-satyr"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

data "aws_security_group" "selected" {
  name = "default"
}

output "selected" {
  value = data.aws_security_group.selected.id
}

