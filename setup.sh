#/bin/bash

mkdir -p ~/.config/nvim/lua

ln -s ${PWD}/nvim/init.vim ~/.config/nvim/init.vim
ln -s ${PWD}/nvim/lua/lsp_config.lua ~/.config/nvim/lua/lsp_config.lua
