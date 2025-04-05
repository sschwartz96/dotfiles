#!/bin/zsh

rm -rf ~/bin/nvim-linux64/
# wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz
wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.tar.gz
# tar -zxvf nvim-linux64.tar.gz -C ~/bin/
tar -zxvf nvim-linux-x86_64.tar.gz -C ~/bin/
# rm nvim-linux64.tar.gz
rm nvim-linux-x86_64.tar.gz
mv ~/bin/nvim-linux-x86_64 ~/bin/nvim-linux64
