#!/bin/bash
W3M_DIR="$HOME/.config/w3m"
# Set the working directory to the script's location
cd "$(dirname "$0")" || exit

# Use wofi to display the links and select one
selected_link=$(cat links.txt | wofi --dmenu -i -p "Select a link:")
echo "Selected link: $selected_link"
# Open the selected link using xdg-open
exec foot w3m -config $W3M_DIR "$selected_link"

# Run w3m with the specified configuration file and open www.google.fi
