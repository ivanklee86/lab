from utilities import move_diagram

from diagrams import Cluster, Diagram, Edge
from diagrams.digitalocean.compute import K8SCluster, K8SNodePool
from diagrams.oci.network import Firewall, LoadBalancer
from diagrams.oci.monitoring import HealthCheck
from diagrams.saas.cdn import Cloudflare
from diagrams.onprem.monitoring import Grafana

diagram_filename = "infrastructure"

with Diagram(
    "Infrastructure", filename=diagram_filename, outformat=["png"], show=False
):
    # Create objects
    cloudflare = Cloudflare("Cloudflare")
    grafana = Grafana('Grafana')
    uptimerobot = HealthCheck('UptimeRobot')

    # Groups
    with Cluster("Civo"):
        with Cluster("lab [network]"):
            firewall = Firewall("lab_k8s_firewall")
            load_balancer = LoadBalancer("[Load Balancer]")

            cluster = K8SCluster("lab [k8s cluster]")
            xsmall_nodes = K8SNodePool("Node Pool [xsmall]")
            small_nodes = K8SNodePool("Node Pool [small]")

    (
        cloudflare
        >> Edge(color="orange", label="allowlisted traffic")
        >> firewall
        >> load_balancer
        >> cluster
        >> [xsmall_nodes, small_nodes]
    )

    cluster >> Edge(label="metrics and logs") >> grafana
    uptimerobot >> Edge(label="synthetic monitoring") >> cloudflare

move_diagram(diagram_filename)
