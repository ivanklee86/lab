resource "civo_kubernetes_cluster" "lab" {
  name         = "lab"
  applications = "-traefik2-loadbalancer"
  firewall_id  = data.terraform_remote_state.networking.outputs.firewall_id
  pools {
    label      = "nodes"
    size       = element(data.civo_size.xsmall.sizes, 0).name
    node_count = 3
  }
}
