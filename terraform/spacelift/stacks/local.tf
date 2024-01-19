locals {
  stacks = [
    {
      name : "spacelift/stacks"
      description : "Manages Spacelift stacks."
      project_root : "terraform/spacelift/stacks"
      labels : ["spacelift"]
    }
  ]
}