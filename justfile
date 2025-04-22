choose:
    just --choose
add:
    yadm add justfile lua luasnippets init.lua

dependencies:
    yay -S --needed --noconfirm lua-language-server node npm neovim stylua
