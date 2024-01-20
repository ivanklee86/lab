resource "civo_kubernetes_cluster" "lab" {
  name         = "lab"
  applications = ""
  kubernetes_version = "1.28.2"
  network_id   = data.terraform_remote_state.networking.outputs.network_id
  firewall_id  = data.terraform_remote_state.networking.outputs.firewall_id
  pools {
    label      = "nodes"
    size       = element(data.civo_size.xsmall.sizes, 0).name
    node_count = 3
  }
}
