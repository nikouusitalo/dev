#!/bin/bash

# Define the directory where you want to search for Markdown files
search_dir="$HOME/document/cheat"

# Use find to locate Markdown files and pipe them to fzf for selection
selected_file=$(find "$search_dir" -type f -name "*.md" | fzf)

#how to view neovim?
# Check if a file was selected
if [ -n "$selected_file" ]; then
    # Use a text viewer to display the selected Markdown file
    # Replace 'cat' with 'less' or another viewer if you prefer
    cat "$selected_file"  | fzf --query="initial_pattern"
fi

#if it same fiel open same markdown
#open other cheat
