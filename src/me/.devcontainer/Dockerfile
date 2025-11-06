FROM ghcr.io/aliuq/devcontainer:base

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && \
    apt-get -y install --no-install-recommends \
    shfmt && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN if ! grep -q "plugins=.*docker" ~/.zshrc; then \
      sed -i "s/^plugins=(\(.*\))/plugins=(\1 docker)/" ~/.zshrc; \
    fi && \
    if ! grep -q "plugins=.*docker-compose" ~/.zshrc; then \
      sed -i "s/^plugins=(\(.*\))/plugins=(\1 docker-compose)/" ~/.zshrc; \
    fi
