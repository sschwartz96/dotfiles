#!/bin/zsh

# Session name
session="JustAskBrett"

cd /home/sam/projects/justaskbrett.com/

# Start New Session with our name
tmux new-session -d -s $session -c ./api
tmux send-keys 'vim' Enter

tmux rename-window 'api'

tmux new-window -n 'api_run' -c ./api
tmux send-keys 'make run' Enter

tmux new-window -n 'ui' -c ./ui
tmux send-keys 'vim' Enter

tmux new-window -n 'ui_run' -c ./ui
tmux send-keys 'pnpm run dev --host' Enter

tmux attach
