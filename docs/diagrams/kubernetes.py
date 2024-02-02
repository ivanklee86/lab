from utilities import move_diagram

from diagrams import Cluster, Diagram
from diagrams.custom import Custom
from diagrams.k8s.compute import Deployment
from diagrams.k8s.network import Ingress
from diagrams.onprem.database import MySQL
from diagrams.onprem.gitops import ArgoCD
from diagrams.onprem.monitoring import Grafana
from diagrams.onprem.vcs import Github
from diagrams.saas.cdn import Cloudflare

diagram_filename = "kubernetes"

with Diagram("Kubernetes", filename=diagram_filename, outformat=["png"], show=False):
    op_vault = Custom("1Password Vault", "../imgs/1password.png")
    grafana_cloud = Grafana("Grafana Cloud")
    lab_repo = Github("lab [Repo]")
    cloudflare = Cloudflare("Cloudflare")
    ghost_mysql = MySQL("MySQL [Ghost]")

    with Cluster("Kubernetes"):
        with Cluster("infrastructure [namespace]"):
            nginx_ingress = Ingress("Ingress")
            nginx_deployment = Custom("ingress-nginx", "../imgs/nginx.png")

            argocd = ArgoCD("ArgoCD")

            op_operator = Custom("1Password Operator", "../imgs/1password.png")

            k8s_monitoring = Grafana("k8s-monitoring")

            metrics_server = Deployment("metrics-server")

        with Cluster("websites[namespace]"):
            ghost = Custom("ghost", "../imgs/ghost.png")
            whoami = Deployment("whoami")
            flame = Deployment("flame")

    cloudflare >> nginx_ingress >> nginx_deployment >> [ghost, whoami, flame]
    ghost >> ghost_mysql
    op_operator >> op_vault
    lab_repo >> argocd
    k8s_monitoring >> grafana_cloud


move_diagram(diagram_filename)
