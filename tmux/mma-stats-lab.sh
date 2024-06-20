#!/bin/zsh

# Session name
session="mma-stats-lab"

cd /home/sam/projects/mma_stat_lab/

# Start New Session with our name
tmux new-session -d -s $session -c ./data
tmux send-keys 'hx' Enter
tmux rename-window 'data'

tmux new-window -n 'db' -c ./db
tmux send-keys 'hx' Enter

tmux new-window -n 'cmd' -c ./db
tmux send-keys 'make db' Enter

tmux split-window -c ./data
tmux send-keys 'sleep 1' Enter
tmux send-keys 'make run' Enter

tmux attach
