#!/bin/bash

choices=("mma-stats-lab")
values=("/home/sam/dotfiles/tmux/mma-stats-lab.sh")

chosen=$(echo "${choices[@]}" | rofi -dmenu -i -p "Select tmux script:")
echo value: $chosen

counter=0
for i in "${choices[@]}"
do
	if [ "$i" = "$chosen" ]
	then
		echo counter: $counter
		file=${values[${counter}]}
		cd $(dirname $file)
		echo $file
		exec alacritty --command $file
	fi
	counter=$((counter+1))
done

