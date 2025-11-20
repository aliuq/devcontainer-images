#!/bin/sh

set -e

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [ ! -d "$ZSH_CUSTOM" ]; then
  echo "Oh My Zsh custom directory not found at $ZSH_CUSTOM. Please install Oh My Zsh first."
  exit 0
fi

echo "Installing pnpm shell completion..."

pnpm_name="pnpm-shell-completion_x86_64-unknown-linux-gnu"
pnpm_url="https://github.com/g-plane/pnpm-shell-completion/releases/latest/download/${pnpm_name}.tar.gz"

mkdir -p /tmp/${pnpm_name}
curl -sSL ${pnpm_url} | tar -xz -C /tmp/${pnpm_name}
mkdir -p ${ZSH_CUSTOM}/plugins/pnpm-shell-completion

cp /tmp/${pnpm_name}/pnpm-shell-completion.plugin.zsh ${ZSH_CUSTOM}/plugins/pnpm-shell-completion/
cp /tmp/${pnpm_name}/pnpm-shell-completion ${ZSH_CUSTOM}/plugins/pnpm-shell-completion/
rm -rf /tmp/${pnpm_name}

if ! grep -q "plugins=.*pnpm-shell-completion" ~/.zshrc; then
  sed -i "s/^plugins=(\(.*\))/plugins=(\1 pnpm-shell-completion)/" ~/.zshrc;
fi

echo "pnpm shell completion installed successfully in Oh My Zsh."
echo "Please restart your terminal or run 'source ~/.zshrc' to apply the changes."
