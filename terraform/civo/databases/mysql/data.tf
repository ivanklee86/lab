data "civo_size" "database" {
  filter {
    key      = "name"
    values   = ["db.xsmall"]
    match_by = "re"
  }
  filter {
    key    = "type"
    values = ["database"]
  }
}

data "civo_database_version" "mysql" {
  filter {
    key    = "engine"
    values = ["mysql"]
  }
}

# Networking remote state
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
