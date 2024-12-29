#!/usr/bin/env bash

packages=(
xorg    
ninja-build
gettext
cmake
unzip
curl
build-essential
libx11-dev
libxinerama-dev
libxft-dev
libfontconfig1-dev
fzf
python3-pip
udiskie
firefox-esr
xdg-desktop-portal-wlr
xdg-desktop-portal-gtk
network-manager-gnome
pavucontrol
imagemagick
zip
curl
network-manager
gpg
brightnessctl
pipewire
pipewire-audio-client-libraries
pamixer
amd64-microcode
mako-notifier
fuzzel
grim
slurp
imv
thunar
android-file-transfer
jq
ncmpcpp
qt6-wayland
zathura
mpd
newsboat
w3m
unzip
tmux
lf
pass
)

for package in "${packages[@]}"; do
    sudo apt-get install "$package" -y
done
