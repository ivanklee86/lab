# Development

## Setup
1. Use `.devcontainer` locally to generate development environment.
2. `eval $(op signin)` to log in to 1Password (or use an access token).

## Working with helm
Update subcharts

```shell
helm dependency update
```
Template manifests

```shell
helm template .
```

## Documentation

1. Run `task images` to generate diagrams.
2. Run `mkdocs serve` to preview documentation.

Resources:
- [IconDuck](https://iconduck.com)
