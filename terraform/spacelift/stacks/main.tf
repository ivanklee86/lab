resource "spacelift_stack" "stacks" {
  for_each = {
    for index, stack in local.stacks :
    stack.name => stack
  }

  administrative                  = true
  autodeploy                      = true
  branch                          = "main"
  description                     = each.value.description
  enable_local_preview            = true
  labels                          = toset(each.value.labels)
  name                            = each.value.name
  manage_state                    = true
  project_root                    = each.value.project_root
  repository                      = "lab"
  space_id                        = "root"
  terraform_version               = "1.7.0"
  terraform_workflow_tool         = "OPEN_TOFU"
  terraform_smart_sanitization    = true
  terraform_external_state_access = each.value.terraform_external_state_access
}
