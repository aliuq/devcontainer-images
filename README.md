# DevContainer Images

[![DevContainer](https://shields.xod.cc/github/actions/workflow/status/aliuq/devcontainer-images/build.yml?label=Build)](./.github/workflows/build.yml)
[![DevContainer](https://shields.xod.cc/github/actions/workflow/status/aliuq/devcontainer-images/build-app.yml?label=Build%20App)](./.github/workflows/build-app.yml)
[![Pulls](https://shields.xod.cc/docker/pulls/aliuq/devcontainer?label=Pulls)](https://hub.docker.com/r/aliuq/devcontainer)
[![features](https://shields.xod.cc/badge/devcontainer--features-blue?logo=github)](https://github.com/aliuq/devcontainer-features)

![base](https://shields.xod.cc/docker/image-size/aliuq/devcontainer/base?label=base)
![alpine](https://shields.xod.cc/docker/image-size/aliuq/devcontainer/alpine?label=alpine)
![debian](https://shields.xod.cc/docker/image-size/aliuq/devcontainer/debian?label=debian)
![me](https://shields.xod.cc/docker/image-size/aliuq/devcontainer/me?label=me)

**Minimal, maintained DevContainer images for development and CI.**

---

Support registries:

- `ghcr.io/aliuq/devcontainer:<tag>`
- `aliuq/devcontainer:<tag>`
- `registry.cn-hangzhou.aliyuncs.com/aliuq/devcontainer:<tag>`

Run a container:

```bash
docker run -it --rm ghcr.io/aliuq/devcontainer:base /bin/zsh
```

## Quick start

Create `./devcontainer/devcontainer.json` file in your workspace root with the following content:

```json
{
  "name": "My DevContainer",
  "image": "ghcr.io/aliuq/devcontainer:base"
}
```

## Build locally

```bash
git clone https://github.com/aliuq/devcontainer-images.git
cd devcontainer-images
# Build the base image
devcontainer build --image-name base:local --workspace-folder src/base
# Build the base image with plain logs
# BUILDKIT_PROGRESS=plain devcontainer build --image-name base:local-1 --workspace-folder src/base
docker run -it --rm base:local /bin/zsh
```

## Available tags

- `devcontainer:base` — Ubuntu-based image
- `devcontainer:alpine` — Alpine image
- `devcontainer:debian` — Debian image
- `devcontainer:me` — personal image

---

## Links

- Devcontainer Features: <https://github.com/devcontainers/features>
- Devcontainer Images: <https://github.com/devcontainers/images>
- Devcontainer Documentation: <https://containers.dev/>
- Devcontainer Cli: <https://github.com/devcontainers/cli>
