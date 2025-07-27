#!/bin/zsh

# Session name
session="yak"

cd /home/sam/projects/yak/

# Start New Session with our name
tmux new-session -d -s $session -c ./data
tmux send-keys 'vim' Enter

tmux new-window -n 'cmd' -c ./db
tmux send-keys 'task air' Enter

tmux attach
