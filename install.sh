#!/bin/bash

echo "installing paperbenni init.lua"
MEMAMOUNT="$(free | sed '/^[^A-Z].*/d' | head -1 | grep -o '[0-9]*' | head -1)"

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
	if [ -e ~/.config/paperbenni/potato.txt ] || [ "$MEMAMOUNT" -lt "7000000" ]; then
		export POTATO="true"
		return 0
	else
		export NOPOTATO="true"
		return 1
	fi
}

[ -e ~/.config/nvim ] || mkdir -p ~/.config/nvim

cp -r ./* ~/.config/nvim/

if is_potato; then
	sed -i '/local ispotato/s/inserthere/true/g' ~/.config/nvim/lua/mypotato.lua
else
	sed -i '/local ispotato/s/inserthere/false/g' ~/.config/nvim/lua/mypotato.lua
fi




