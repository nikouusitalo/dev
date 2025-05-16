#!/bin/bash

# Read the list of packages from the file
mapfile -t packages < packages.txt

# Install the packages
sudo pacman -S --needed "${packages[@]}"
