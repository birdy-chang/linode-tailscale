terraform {
  required_providers {
    linode = {
      source = "linode/linode"
      version = "2.23.1"
    }
  }
}

provider "linode" {
  token = "${var.linode_token}"
}
