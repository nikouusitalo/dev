#!/bin/sh
 
### Terminal
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
sudo chmod 644 /usr/share/keyrings/wezterm-fury.gpg

sudo apt update
sudo apt install wezterm-nightly
### Browser

sudo apt-get install qutebrowser


curl -fsSL https://repo.vivaldi.com/archive/linux_signing_key.pub | gpg --dearmor | sudo tee /usr/share/keyrings/vivaldi.gpg > /dev/null
echo deb [arch=amd64,armhf signed-by=/usr/share/keyrings/vivaldi.gpg] https://repo.vivaldi.com/archive/deb/ stable main | sudo tee /etc/apt/sources.list.d/vivaldi.list
sudo apt update
sudo apt install vivaldi-stable

# awesome
sudo apt-get install awesome
sudo apt-get install awesome-extra


### Sway packages
sudo apt install -y sway waybar swaylock swayidle swaybg
sudo apt install -y gvfs-backends

### File manager (thunar)
sudo apt install -y thunar thunar-archive-plugin thunar-volman file-roller

### Terminal

###
sudo apt install -y mtools dosfstools acpi acpid avahi-daemon
sudo systemctl enable acpid
sudo systemctl enable avahi-daemon

### Polkit
# sudo apt install -y policykit-1-gnome # (doesn't work on wayland; @debian)
sudo apt install -y polkit-kde-agent-1

### Network Manager
sudo apt install -y network-manager network-manager-gnome 

### Volume and brightness utilities
sudo apt install -y light pamixer

### Sound packages
sudo apt install -y pipewire pipewire-audio pipewire-pulse pipewire-alsa wireplumber alsa-utils pavucontrol

### Launcher and notification daemon
sudo apt install -y rofi sway-notification-center  libnotify-bin 
### Bisa juga pakai mako-notifier tapi swaync lebih better

### Clipboard manager
sudo apt install -y  clipman

### Redshift replacement for wayland
sudo apt install -y wlsunset

### Screenshot stuff

sudo apt install -y grim grimshot slurp imagemagick zenity wl-clipboard

# Build nwg-look
sudo apt install -y nwg-lookg

sudo apt install -y wf-recorder

sudo apt install -y wayland-protocols xwayland 
sudo apt install -y libgtk-layer-shell-dev # ?
sudo apt install -y xdg-desktop-portal-wlr
sudo apt install -y dex jq 
sudo apt install -y build-essential 
sudo apt install -y libpam0g-dev libxcb1-dev

### Microcode for Intel/AMD 
sudo apt install -y amd64-microcode
# sudo apt install -y intel-microcode 

#### For GTK setting
#### using gsettings command
sudo apt install -y libglib2.0-bin

### it will also install adwaita icon
sudo apt install -y arc-theme

### PDF viewer
sudo apt install -y mupdf zathura

### Image viewer
sudo apt install -y mirage nsxiv

### Music/media player packages
sudo apt install -y mpd ncmpcpp mpv

### firefox dependencies (build instruction at the on of this script)
sudo apt install -y libdbus-glib-1-2

### Fonts and icons for now
sudo apt install -y fonts-firacode fonts-liberation2
sudo apt install -y fonts-noto-color-emoji fonts-font-awesome

### Printing and bluetooth (if needed)
sudo apt install -y cups system-config-printer simple-scan
sudo apt install -y bluez blueman

sudo systemctl enable cups
sudo systemctl enable bluetooth

##############################
###### Another packages ######
##############################

### Neovim (Recomended) 
## Build neovim from source:
## https://github.com/neovim/neovim/wiki/Building-Neovim
 sudo apt-get install -y ninja-build gettext cmake unzip curl

 cd /temp
 git clone https://github.com/neovim/neovim
 cd neovim
 git checkout stable
 make CMAKE_BUILD_TYPE=RelWithDebInfo
 sudo make install

### Nodejs (require for neovim config)
# Download binary file, and put the directory into ~/.local/src/
# ex: ~/.local/src/node-v18.16.1-linux-x64/*
# And source it in zsh profile

### Firefox (binary)
## Build firefox:
# sudo apt install -y libdbus-glib-1-2 # require dependencies
# download firefox*.tar.bz2: wget https://download-installer.cdn.mozilla.net/pub/firefox/releases/115.0.2/linux-x86_64/en-US/firefox-115.0.2.tar.bz2
# if link not working (version changed), download from: https://support.mozilla.org/en-US/kb/install-firefox-linux
# step:
# - download source code from official website
# - extract the file: tar xjf firefox-*.tar.bz2
# - mv firefox /opt
# - ln -s /opt/firefox/firefox /usr/local/bin/firefox
# - download .desktop file: wget https://raw.githubusercontent.com/mozilla/sumo-kb/main/install-firefox-linux/firefox.desktop
# - sudo mv firefox.desktop /usr/share/applications/
# done....

### OBS Studio (if needed)
 sudo apt install -y qt6-wayland
# sudo apt install -y linux-headers-6.1.0-10-amd64 v4l2loopback-dkms
# sudo apt install -y obs-studio
# sudo modprobe v4l2loopback devices=1 video_nr=10 card_label="OBS Camera" exclusive_caps=1

### Microsoft font | msfont
# sudo apt install software-properties-common -y
sudo apt-add-repository contrib non-free -y
# sudo apt install ttf-mscorefonts-installer
# sudo fc-cache -fv

### Samba
# sudo apt install -y samba smbclient cifs-utils
# sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.bak
#
##Method 1) Using existing user (currently used)
# mkdir -p /home/agung/shares/{public_files,protected_files}
#
##Method 2) Create new smbgroup and smbuser
# sudo mkdir -p /share/{public_files,protected_files}
# sudo groupadd --system smbgroup
# sudo useradd --system --no-create-home --group smbgroup -s /bin/false smbuser
# sudo chown -R smbuser:smbgroup /shares
# 
## Create config file:
# sudo nvim /etc/samba/smb.conf
#
# Remove comment based on method you are using
#
#############^ smb.conf ^#############
#[global]
#server string = File Server
#workgroup = WORKGROUP
#security = user
#map to guest = Bad User
#name resolve order = bcast host

#[Public Files]
##path = /shares/public_files
##path = /home/agung/shares/public_files
##force user = smbuser
##force group = smbgroup
##force user = agung
##force group = agung
#create mask = 0664
#force create mode = 0664
#directory mask = 0775
#force directory mode = -775
#public = yes
#writable = yes

#[Protected Files]
##path = /shares/protected_files
##path = /home/agung/shares/protected_files
##force user = smbuser
##force group = smbgroup
##force user = agung
##force group = agung
#create mask = 0664
#force create mode = 0664
#directory mask = 0775
#force directory mode = -775
#public = yes
#writable = no
#############_ smb.conf _#############
#
# sudo systemctl restart smbd
