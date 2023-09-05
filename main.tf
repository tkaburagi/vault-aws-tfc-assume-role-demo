terraform {

}

provider "vault" {}
provider "tfe" {}
provider "random" {}

resource "random_pet" "pet" {}