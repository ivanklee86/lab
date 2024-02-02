resource "civo_database" "database" {
  name    = "mysql"
  size    = element(data.civo_size.database.sizes, 0).name
  nodes   = 1
  engine  = element(data.civo_database_version.mysql.versions, 0).engine
  version = element(data.civo_database_version.mysql.versions, 0).version

  network_id  = data.terraform_remote_state.networking.outputs.network_id
  firewall_id = data.terraform_remote_state.networking.outputs.firewall_id
}
