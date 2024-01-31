# Development

## Usage
1. Use `.devcontainer` locally to generate development environment.
2. `eval $(op signin)` to log in to 1Password (or use an access token).
3. Run `task --list` to see all the commands!

## Tags

Since this is a monolith, I'm using the following scheme:

| Component | Tag format |
|-----------|------------|
| Terraform Modules | `tm_vX.Y.Z` |

*Note*: Terraform has a weird issue where `/` in the git ref is interepreted as part of the path (e.g. `//`).  Sadness. 😭

## Resources

| Name | Link | Descriptions |
|------|------|--------------|
| IconDuck | [Link](https://iconduck.com) | Handy icons for lots of things. |
