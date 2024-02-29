#!/bin/zsh

xdo raise -N Polybar
xdo raise -a 'Polybar tray window'
echo "$HOST"

# if on the laptop
if [ "$HOST" = "lenovo-artix" ]
then
	~/dotfiles/scripts/hideIt.sh --name '^polybar-lenovo_eDP' --toggle
else
	~/dotfiles/scripts/hideIt.sh --name '^polybar-bottom' --toggle &
	~/dotfiles/scripts/hideIt.sh --name '^polybar-top' --toggle
fi

~/dotfiles/scripts/hideIt.sh --name 'Polybar tray window' --toggle
