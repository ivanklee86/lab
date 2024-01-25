resource "civo_kubernetes_cluster" "lab" {
  name               = "lab"
  kubernetes_version = "1.28.2-k3s1"
  network_id         = data.terraform_remote_state.networking.outputs.network_id
  firewall_id        = data.terraform_remote_state.networking.outputs.firewall_id
  pools {
    label      = "nodes"
    size       = element(data.civo_size.kubernetes_sizes.sizes, 0).name
    node_count = 2
  }
}

resource "civo_kubernetes_node_pool" "small" {
  cluster_id = civo_kubernetes_cluster.lab.id
  node_count = 2
  size       = element(data.civo_size.kubernetes_sizes.sizes, 1).name // Small
  region     = "NYC1"
}
