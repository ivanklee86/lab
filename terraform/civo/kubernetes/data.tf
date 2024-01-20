# CIVO node sizes
data "civo_size" "xsmall" {
  filter {
    key    = "type"
    values = ["kubernetes"]
  }

  sort {
    key       = "ram"
    direction = "asc"
  }
}

# Netowrking remote state
data "terraform_remote_state" "networking" {
  backend = "remote"

  config = {
    hostname     = "spacelift.io"
    organization = "ivanklee86"

    workspaces = {
      name = "civo-networking"
    }
  }
}
