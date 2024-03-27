#!/bin/zsh

######
#
# This script must be run where it is located
#
#####

mkdir ~/.config

mkdir ~/.config/polybar/
mkdir ~/.config/dunst

# nvim
ln -s $PWD/nvim/ ~/.config/nvim

# essential
ln -s $PWD/.xinitrc ~/.xinitrc
ln -s $PWD/.zshrc ~/.zshrc
ln -s $PWD/.tmux.conf ~/.tmux.conf

# desktop-env
ln -s $PWD/desktop_env/sxhkdrc ~/.config/sxhkd/sxhkdrc
ln -s $PWD/desktop_env/bspwmrc ~/.config/bspwm/bspwmrc
ln -s $PWD/desktop_env/picom.conf ~/.config/picom/picom.conf
ln -s $PWD/desktop_env/config ~/.config/polybar/config
ln -s $PWD/desktop_env/alacritty.toml ~/.config/alacritty/alacritty.toml
ln -s $PWD/desktop_env/alacritty_themes/kanagawa_wave.toml ~/.config/alacritty/kanagawa_wave.toml
ln -s $PWD/desktop_env/config.rasi ~/.config/rofi/config.rasi
ln -s $PWD/desktop_env/dunstrc ~/.config/dunst/dunstrc
ln -s $PWD/desktop_env/config.toml ~/.config/helix/config.toml

# scripts
ln -s $PWD/scripts/rclone-sync.sh ~/scripts/
