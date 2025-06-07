from utilities import move_diagram

from diagrams import Cluster, Diagram, Edge
from diagrams.custom import Custom
from diagrams.onprem.vcs import Github
from diagrams.programming.language import Python

diagram_filename = "tooling"

with Diagram("Tooling", filename=diagram_filename, outformat=["png"], show=False):
    # Create objects
    spacelift = Custom("", "../imgs/spacelift.png")
    op_vault = Custom("1Password Vault", "../imgs/1password.png")

    with Cluster("devcontainer [Local]"):
        dev_container = Custom("DevContainer [Local]", "../imgs/devcontainer.png")

        task = Custom("Task", "../imgs/task.png")

        with Cluster("Tasks"):
            opentofu = Custom("OpenTofu", "../imgs/opentofu.png")
            python = Python("Python")
            op_cli = Custom("1Password CLI", "../imgs/1password.png")

    with Cluster("Github.com"):
        github = Github("Github")
        github_actions = Custom("Github Actions [CI]", "../imgs/github_actions.png")

    dev_container >> github >> Edge(label="CI/CD") >> github_actions
    task >> [opentofu, python, op_cli]
    github >> Edge(label="IaC") >> spacelift
    op_cli >> op_vault

move_diagram(diagram_filename)
