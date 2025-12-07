FROM ghcr.io/aliuq/devcontainer:base

COPY ./scripts /usr/local/share/

ENV PATH="/root/.bun/bin:${PATH}"

RUN set -eux; export DEBIAN_FRONTEND=noninteractive; \
    sudo apt update && sudo apt upgrade -y && \
    sudo apt install -y --no-install-recommends \
    vim && \
    rm -rf /var/lib/apt/lists/*
