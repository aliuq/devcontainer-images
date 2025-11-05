#!/bin/bash

set -e

source test-utils.sh

# git
check "git installed" git --version
# fzf
check "fzf installed" fzf --version
# eza
check "eza installed" eza --version
# zoxide
check "zoxide installed" zoxide --version
# mise
check "mise installed" mise --version
# starship
check "starship not installed" bash -c 'if ! command -v starship &> /dev/null; then exit 0; else exit 1; fi'

reportResults
