choose:
    just --choose

fetch:
    rsync -av --exclude='justfile' ~/.config/nvim/ ./

dependencies:
    #!/usr/bin/env bash
    if command -v yay &> /dev/null; then
        yay -S --needed --noconfirm lua-language-server node npm neovim stylua
    elif command -v apt &> /dev/null; then
        sudo apt update
        sudo apt install -y lua-language-server nodejs npm neovim
    else
        echo "Error: Unsupported package manager. Please install dependencies manually." >&2
        exit 1
    fi
