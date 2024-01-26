from utilities import move_diagram

from diagrams import Cluster, Diagram, Edge
from diagrams.custom import Custom
from diagrams.programming.language import Python

diagram_filename = "tooling"

with Diagram(
    "Tooling", filename=diagram_filename, outformat=["png"], show=False
):
    # Create objects
    spacelift = Custom('', '../imgs/spacelift.png')

    with Cluster("devcontainer [Local]"):
        dev_container = Custom('DevContainer [Local]', '../imgs/devcontainer.png')
        opentofu = Custom('OpenTofu', '../imgs/opentofu.png')
        python = Python("Python")

    with Cluster("Github.com"):
        github = Custom('Github', '../imgs/github.png')
        github_actions = Custom('Github Actions', '../imgs/github_actions.png')
        cloud_dev_container = Custom('DevContainer [Cloud]', '../imgs/devcontainer.png')

    dev_container >> github >> Edge(label="CI/CD") >> github_actions
    github >> Edge(label="IaC") >> spacelift

move_diagram(diagram_filename)
