#!/usr/bin/env bash

# Select from languages or commands using fzf
selected=$(cat ~/.config/scripts/tmux-cht-languages ~/.config/scripts/tmux-cht-command | fzf)
if [[ -z $selected ]]; then
    exit 0
fi

# Read user input without using the -r flag
read -p "Enter Query: " query

# Check if the selected item is a language
if grep -qs "$selected" ~/.config/scripts/tmux-cht-languages; then
    # Replace spaces with '+' in the query (quote the variable to prevent word splitting)
    query=$(echo "$query" | tr ' ' '+')
    
    # Open a new tmux window and run the curl command, preventing word splitting with quotes
    tmux neww bash -c "echo \"curl cht.sh/$selected/$query/\" && curl cht.sh/$selected/$query && while [ : ]; do sleep 1; done"
else
    # If it's a command, fetch command data and use less (quote the query to prevent word splitting)
    curl -s cht.sh/$selected~"$query" | less
fi
