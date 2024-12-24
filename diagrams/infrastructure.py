from utilities import move_diagram

from diagrams import Cluster, Diagram, Edge
from diagrams.custom import Custom
from diagrams.digitalocean.compute import K8SCluster, K8SNodePool
from diagrams.oci.monitoring import HealthCheck
from diagrams.oci.network import Firewall, LoadBalancer
from diagrams.onprem.database import MySQL
from diagrams.onprem.monitoring import Grafana
from diagrams.saas.cdn import Cloudflare

diagram_filename = "infrastructure"

with Diagram(
    "Infrastructure", filename=diagram_filename, outformat=["png"], show=False
):
    # Create objects
    cloudflare = Cloudflare("Cloudflare")
    grafana = Grafana("Grafana")
    uptimerobot = HealthCheck("UptimeRobot")
    tailscale = Custom("Tailscale", "../imgs/tailscale.jpg")

    # Groups
    with Cluster("Civo"):
        with Cluster("lab [network]"):
            firewall = Firewall("lab_k8s_firewall")
            load_balancer = LoadBalancer("[Load Balancer]")

            cluster = K8SCluster("lab [k8s cluster]")
            xsmall_nodes = K8SNodePool("Node Pool [xsmall]")
            small_nodes = K8SNodePool("Node Pool [small]")
            medium_nodes = K8SNodePool("Node Pool [medium]")

            mysql = MySQL("MySQL")

    with Cluster("Home Network"):
        unifi_gateway = Custom("Unifi Gateway", "../imgs/ubiquiti.png")
        tailscale_exit_node = Custom("Tailscale [Exit Node]", "../imgs/tailscale.jpg")

    (
        cloudflare
        >> Edge(color="orange", label="allowlisted traffic")
        >> firewall
        >> load_balancer
        >> cluster
        >> [xsmall_nodes, small_nodes, medium_nodes]
    )

    cluster >> Edge(label="metrics and logs") >> grafana
    uptimerobot >> Edge(label="synthetic monitoring") >> cloudflare

    (
        tailscale
        >> tailscale_exit_node
        >> Edge(label="IP allowlist for k8s API")
        >> cluster
    )
    unifi_gateway >> cluster

move_diagram(diagram_filename)
