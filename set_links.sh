#!/bin/zsh

######
#
# This script must be run where it is located
#
#####


# nvim
ln -s $PWD/nvim/init.vim ~/.config/nvim/init.vim
ln -s $PWD/nvim/lua/lsp_config.lua ~/.config/lua/lsp_config.lua

# essential
ln -s $PWD/.xinitrc ~/.xinitrc
ln -s $PWD/.zshrc ~/.zshrc
ln -s $PWD/.tmux.conf ~/.tmux.conf

# desktop-env
ln -s $PWD/desktop_env/sxhkdrc ~/.config/sxhkd/sxhkdrc
ln -s $PWD/desktop_env/bspwmrc ~/.config/bspwm/bspwmrc
ln -s $PWD/desktop_env/picom.conf ~/.config/picom/picom.conf
ln -s $PWD/desktop_env/config ~/.config/polybar/config
ln -s $PWD/desktop_env/alacritty.yml ~/.config/alacritty/alacritty.yml
ln -s $PWD/desktop_env/config.rasi ~/.config/rofi/config.rasi

# scripts
ln -s $PWD/scripts/rclone-sync.sh ~/scripts/rclone-sync.sh
