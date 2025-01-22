#!/bin/zsh

rm -rf ~/bin/nvim-linux64/
wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz
tar -zxvf nvim-linux64.tar.gz -C ~/bin/
rm nvim-linux64.tar.gz
