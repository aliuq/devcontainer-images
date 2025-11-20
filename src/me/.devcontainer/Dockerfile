FROM ghcr.io/aliuq/devcontainer:base

COPY ./scripts /usr/local/share/

RUN set -eux; export DEBIAN_FRONTEND=noninteractive; \
    # Enable docker and docker-compose plugins for oh-my-zsh
    if ! grep -q "plugins=.*docker" ~/.zshrc; then \
      sed -i "s/^plugins=(\(.*\))/plugins=(\1 docker)/" ~/.zshrc; \
    fi && \
    if ! grep -q "plugins=.*docker-compose" ~/.zshrc; then \
      sed -i "s/^plugins=(\(.*\))/plugins=(\1 docker-compose)/" ~/.zshrc; \
    fi && \
    # pnpm shell completion
    sudo chmod +x /usr/local/share/pnpm-shell-completion.sh && \
    /usr/local/share/pnpm-shell-completion.sh && \
    # httpie: https://httpie.io/docs/cli/linux
    curl -SsL https://packages.httpie.io/deb/KEY.gpg | sudo gpg --dearmor -o /usr/share/keyrings/httpie.gpg && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/httpie.gpg] https://packages.httpie.io/deb ./" | sudo tee /etc/apt/sources.list.d/httpie.list && \
    sudo apt update -y && \
    sudo apt install -y httpie && \
    rm -rf /var/lib/apt/lists/*
