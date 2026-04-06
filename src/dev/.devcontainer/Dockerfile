FROM ghcr.io/aliuq/devcontainer:base

ARG PNPM_HOME="/root/.local/share/pnpm"
ENV PNPM_HOME="${PNPM_HOME}" \
    PATH="/root/.bun/bin:${PNPM_HOME}:${PATH}"

RUN set -eux; export DEBIAN_FRONTEND=noninteractive; \
    sudo apt-get update && sudo apt-get upgrade -y && \
    sudo apt-get install -y --no-install-recommends \
    vim && \
    rm -rf /var/lib/apt/lists/*
