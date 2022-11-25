#!/usr/bin/env bash

# Install paperbenni's Neovim.

NVIMCMD=${nvimcmd:-nvim}

checkcommand() {
	if ! command -v "$1"; then
		echo "$1 not found, please install" 1>&2
		exit 1
	fi
}

backup_config() {
	cd || exit 1
	mv .config/nvim .config/"$(date '+%y%m%d%H%M%S')"_nvim_backup 2>/dev/null
	mkdir -p .config/nvim
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
	if ! command -v "$CURLCMD"; then
		nix-env -i curl
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
	checkcommand "$CURLCMD"
	checkcommand npm
	checkcommand cmake
	checkcommand pip
	checkcommand luarocks
	checkcommand node
	# TODO check node version
}

ensure_repo() {
	if ! [ -e ./init.lua ]; then
		mkdir -p ~/.cache/paperbenni_nvim
		cd ~/.cache/paperbenni_nvim || exit 1
		if ! [ -e init.lua ]; then
			git clone https://github.com/paperbenni/init.lua
		fi
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
	if [ -e ~/.config/paperbenni/potato.txt ] || [ "$MEMAMOUNT" -lt "7000000" ]; then
		export POTATO="true"
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

	if is_potato; then
		sed -i '/local ispotato/s/inserthere/true/g' ~/.config/nvim/lua/mypotato.lua
	else
		sed -i '/local ispotato/s/inserthere/false/g' ~/.config/nvim/lua/mypotato.lua
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
	echo "installing treesitter parser"
	PLUGINDIR="$HOME"/.local/share/nvim/site/pack/packer/start

	if ! is_potato; then
		# install all treesitters at once
		$NVIMCMD +'silent! TSInstallSync all' +qall &>/dev/null
	else
		TREESITTERLIST="$(
			grep '^list.[a-z0-9]* = {' \
				"$PLUGINDIR"/nvim-treesitter/lua/nvim-treesitter/parsers.lua |
				sed 's/^list.//g' | sed 's/ = {$//g'
		)"
		echo "installing treesitter plugins one by one"
		if [ "$(wc -l <<<"$TREESITTERLIST")" -gt 10 ]; then
			export TREESITTERLIST
			while IFS= read -r sitter; do
				if ! [ -e "$PLUGINDIR"/nvim-treesitter/parser/"$sitter".so ]; then
					$NVIMCMD +'silent! TSInstallSync '"$sitter" +qall &>/dev/null
				fi
			done <<<"$TREESITTERLIST"
		fi
	fi

	# TODO: install coq deps

	# compile telescope fzf
	if ! [ -e "$PLUGINDIR"/telescope-fzf-native.nvim/build/libfzf.so ]; then
		cd "$PLUGINDIR"/telescope-fzf-native.nvim || exit 1
		cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release &&
			cmake --build build --config Release &&
			cmake --install build --prefix build
	fi

}

main() {
	echo "installing paperbenni's neovim config"
	echo "warning, this will override existing configs"

	# Keep what this function does distribution agnostic!

	backup_config
	install_packer
	install_cfg_files
	install_plugins

	echo "finished installing paperbenni's neovim config"
}

if [ "$0" = "$BASH_SOURCE" ]; then
	check_nix_install
	check_dependencies
	install_providers
	main "$@"
fi
