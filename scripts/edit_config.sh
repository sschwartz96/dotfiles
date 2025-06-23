#!/bin/bash

choice_file=~/dotfiles/scripts/config_list.txt
choices=($(awk '{print $1}' $choice_file))
values=($(awk '{print $2}' $choice_file ))

#chosen=$(awk '{print $1}' $choice_file | dmenu -fn "Fira Code:bold:pixelsize=14" -i -p "Which config file to edit?")
chosen=$(awk '{print $1}' $choice_file | rofi -dmenu -i -p "Which config file to edit?")

counter=0
for i in "${choices[@]}"
do
	if [ "$i" = "$chosen" ]
	then
		file=${values[${counter}]}
		cd $(dirname $file)
		echo $file
		# alacritty -e helix $file
		bspc rule -a Alacritty rectangle=740x960+0+0 center=on state=floating
		alacritty -e nvim $file & disown
		sleep 1 && bspc rule -r tail
	fi
	counter=$((counter+1))
done
