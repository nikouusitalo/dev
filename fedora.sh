#!/bin/bash

# Read the list of packages from the file
mapfile -t packages < packages.txt

# Install the packages
sudo dnf install "${packages[@]}"


sudo dnf remove \
gnome-boxes \
gnome-maps \
gnome-weather \
gnome-contacts \
gnome-photos \
gnome-clocks \
gnome-calendar \
gnome-music \
gnome-tour \
totem \
cheese \
yelp \
rhythmbox \
showtime \
ptyxis

