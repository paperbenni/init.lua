#!/bin/bash

echo "quickly installing init.lua"
source install.sh

backup_config
install_cfg_files
nvim -c PackerInstall

