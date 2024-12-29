#!/usr/bin/env bash

codename=$(lsb_release -a 2>/dev/null | grep "Codename" | awk '{print $2}')

packages=(
    yt-dlp
    linux-image-amd64
)

for package in "${packages[@]}"; do
    echo "Installing $package for release codename $codename..."
    sudo apt-get install -t "$codename"-backports "$package" -y
done

