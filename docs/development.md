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

## Images

- [IconDuck](https://iconduck.com)
