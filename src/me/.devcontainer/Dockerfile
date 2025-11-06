FROM ghcr.io/aliuq/devcontainer:base

RUN set -eux; \
    # Enable docker and docker-compose plugins for oh-my-zsh
    if ! grep -q "plugins=.*docker" ~/.zshrc; then \
      sed -i "s/^plugins=(\(.*\))/plugins=(\1 docker)/" ~/.zshrc; \
    fi && \
    if ! grep -q "plugins=.*docker-compose" ~/.zshrc; then \
      sed -i "s/^plugins=(\(.*\))/plugins=(\1 docker-compose)/" ~/.zshrc; \
    fi && \
    \
    # Install development dependence via mise
    mise use -y -g \
    # Tools
    shfmt@latest jq@latest \
    # Web
    bun@latest node@lts yarn@1 pnpm@latest \
    # Python
    python@3 uv@latest && \
    # Clear cache
    mise cache clear

RUN set -eux; \
    # httpie: https://httpie.io/docs/cli/linux
    curl -SsL https://packages.httpie.io/deb/KEY.gpg | sudo gpg --dearmor -o /usr/share/keyrings/httpie.gpg && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/httpie.gpg] https://packages.httpie.io/deb ./" | sudo tee /etc/apt/sources.list.d/httpie.list && \
    sudo apt update -y && \
    sudo apt install -y httpie && \
    rm -rf /var/lib/apt/lists/*
