#!/usr/bin/env bash

# Use `find` to select a directory interactively
selected=$(find ~/code/ ~/dotfiles/.config/ -mindepth 1 -maxdepth 1 -type d | fzf)

# Exit if no selection is made
if [[ -z $selected ]]; then
    exit 0
fi

# Generate a sanitized session name from the selected directory's basename
selected_name=$(basename "$selected" | tr ":,." "____")

# Function to switch or attach to a tmux session
switch_to() {
    if [[ -z "$TMUX" ]]; then
        tmux attach-session -t "$selected_name"
    else
        tmux switch-client -t "$selected_name"
    fi
}

# Check if the session already exists
if tmux has-session -t "$selected_name" 2>/dev/null; then
    switch_to
    exit 0
fi

# Create a new tmux session with the selected directory
tmux new-session -ds "$selected_name" -c "$selected"
