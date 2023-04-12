#!/usr/bin/env bash

# Install paperbenni's Neovim.

NVIMCMD=${nvimcmd:-nvim}

ismacos() {
    uname | grep -q 'Darwin'
}

# fake access to root, setup works without root on termux
if command -v termux-setup-storage; then
    sudo() {
        $@
    }

fi

checkcommand() {
    if ! command -v "$1"; then
        echo "$1 not found, please install" 1>&2
        exit 1
    fi
}

backup_config() {
    pushd "$HOME" || exit 1
    mv .config/nvim .config/"$(date '+%y%m%d%H%M%S')"_nvim_backup 2>/dev/null
    mkdir -p .config/nvim
    popd || exit 1
}

check_nix_install() {
    if ! command -v nix-env; then return 1; fi

    if ! command -v pip2 && ! python2 -c "import neovim"; then
        nix-env -i -E 'f: with import <nixpkgs> { }; (python2.withPackages(ps: [ ps.pynvim ] ))'
    fi
    if ! command -v pip3 && ! python3 -c "import neovim"; then
        nix-env -i -E 'f: with import <nixpkgs> { }; (python3.withPackages(ps: [ ps.pynvim ] ))'
    fi
    if ! command -v "$NVIMCMD"; then
        nix-env -i neovim
    fi
    if ! command -v npm; then
        nix-env -i nodejs
    fi
}

install_providers() {
    echo "installing neovim providers"
    for x in 2 3; do
        if ! python$x -c "import neovim"; then
            sudo pip$x install neovim pynvim
        fi
    done
    if ! command -v nvim; then
        if ! npm list -g | grep 'neovim'; then
            sudo npm install -g neovim
        fi
        # TODO check for gem existance
        if ! gem list | grep 'neovim'; then
            sudo gem install neovim
        fi
    fi
}

check_dependencies() {
    checkcommand npm
    checkcommand cmake
    checkcommand pip
    checkcommand luarocks
    checkcommand sqlite3
    checkcommand node
    if ! python3 -m venv --help &>/dev/null; then
        if command -v termux-setup-storage; then
            pip3 install --upgrade virtualenv
        elif command -v pacman &>/dev/null; then
            sudo pacman -S --noconfirm --needed python-virtualenv
        fi
        if ! python3 -m venv --help &>/dev/null; then
            echo "please install python venv"
        fi
        exit 1
    fi
    NODEVERSION="$(node --version | grep -o '^v[0-9]*\.' | grep -o '[0-9]*')"
    if ! [ "$NODEVERSION" -eq "$NODEVERSION" ]; then
        echo "could not determine node version"
        exit 1
    fi
    if ! [ "$NODEVERSION" -gt 16 ]; then
        echo "node version 16 or newer is required"
        if command -v apt &>/dev/null; then
            curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash - &&
                sudo apt-get install -y nodejs
        fi
    fi

}

ensure_repo() {
    if ! [ -e ./init.lua ]; then
        mkdir -p ~/.cache/paperbenni_nvim
        cd ~/.cache/paperbenni_nvim || exit 1
        if ! [ -e init.lua ]; then
            git clone https://github.com/paperbenni/init.lua
        fi
        cd ~/.cache/paperbenni_nvim/init.lua || exit 1
        echo "using git cache init.lua"
        if ! [ -e init.lua ]; then
            echo "failed to clone config"
            exit 1
        fi
    fi
}

is_potato() {
    if [ -n "$POTATO" ]; then
        return 0
    fi
    if [ -n "$NOPOTATO" ]; then
        return 1
    fi

    if [ -e ~/.config/paperbenni/nopotato.txt ]; then
        export NOPOTATO="true"
        return 1
    fi

    MEMAMOUNT="$(free | sed '/^[^A-Z].*/d' | head -1 | grep -o '[0-9]*' | head -1)"
    if command -v termux-setup-storage ||
        [ -e ~/.config/paperbenni/potato.txt ] ||
        [ "$MEMAMOUNT" -lt "7000000" ]; then
        export POTATO="true"
        echo "optimizing for low end device"
        return 0
    else
        export NOPOTATO="true"
        return 1
    fi
}

install_cfg_files() {
    ensure_repo
    [ -e ~/.config/nvim ] || mkdir -p ~/.config/nvim

    cp -r ./* ~/.config/nvim/
    POTATOFILE="$HOME"/.config/nvim/lua/mypotato.lua

    if ismacos
    then
    echo '
local ispotato = false
return ispotato' > "$POTATOFILE"
    
    elif is_potato; then
        echo "machine is a potato"
        sed -i '/local ispotato/s/inserthere/true/g' "$POTATOFILE"
    else
        echo "machine is not a potato"
        sed -i '/local ispotato/s/inserthere/false/g' "$POTATOFILE"
    fi

}

install_packer() {
    [ -e ~/.local/share/nvim/site/pack/packer/start/packer.nvim ] || {
        echo "installing packer.nvim"
        git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
    }
}

install_plugins() {
    echo "installing packer plugins"
    $NVIMCMD -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
    PLUGINDIR="$HOME"/.local/share/nvim/site/pack/packer/start
    echo "installing all treesitter plugins, this may take a long time"
    $NVIMCMD +'silent! TSInstallSync all' +qall &>/dev/null

    # compile telescope fzf
    if ! [ -e "$PLUGINDIR"/telescope-fzf-native.nvim/build/libfzf.so ]; then
        cd "$PLUGINDIR"/telescope-fzf-native.nvim || exit 1
        make
    fi
    if is_potato; then
        for _ in /home/benjamin/.virtualenvs/debugpy/lib/python3.*/site-packages/debugpy; do
            echo "debugpy already installed"
            export DEBUGPYINSTALLED="true"
            break
        done
        if [ -n "$DEBUGPYINSTALLED" ]; then
            echo "installing debugpy"
            mkdir ~/.virtualenvs
            cd ~/.virtualenvs || exit 1
            python -m venv debugpy
            debugpy/bin/python -m pip install debugpy
        fi
    fi

    # install coq deps
    if ! [ -e "$PLUGINDIR"/coq_nvim/.vars ]; then
        $NVIMCMD -c "COQdeps"
    fi

}

install_dependencies() {

    # automatically install required
    # packages when on instantOS
    if command -v instantinstall; then
        instantinstall npm
        instantinstall python-pip
        instantinstall luarocks
        instantinstall cmake
        instantinstall sqlite3
        instantinstall python-virtualenv
    fi

    if ismacos; then
        brew install python
        brew install cmake
        brew install luarocks
        brew install sqlite
        pip install virtualenv
    fi

}

main() {
    echo "installing paperbenni's neovim config"
    echo "warning, this will override existing configs"

    # Keep what this function does distribution agnostic!

    backup_config
    install_cfg_files
    install_packer
    install_plugins

    echo "finished installing paperbenni's neovim config"
}

if [ "$0" = "$BASH_SOURCE" ]; then
    check_nix_install
    install_dependencies
    check_dependencies
    install_providers
    main "$@"
fi
