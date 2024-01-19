resource "spacelift_stack" "stacks" {
  for_each = toset(local.stacks)

  administrative          = true
  autodeploy              = true
  branch                  = "master"
  description             = each.value.description
  labels                  = toset(each.value.labels)
  name                    = each.value.name
  project_root            = each.value.project_root
  repository              = "lab"
  space_id                = "root"
  terraform_version       = "1.6.0"
  terraform_workflow_tool = "OPEN_TOFU"
}
