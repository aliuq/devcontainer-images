FROM ghcr.io/aliuq/devcontainer:base

COPY ./scripts /usr/local/share/

ENV PATH="/root/.bun/bin:${PATH}"

RUN set -eux; export DEBIAN_FRONTEND=noninteractive; \
    sudo apt-get update && sudo apt-get upgrade -y && \
    sudo apt-get install -y --no-install-recommends \
    vim && \
    rm -rf /var/lib/apt/lists/*
