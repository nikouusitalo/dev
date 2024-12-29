#!/usr/bin/env bash
git clone -b v0.10.3 https://github.com/neovim/neovim $HOME/vault/code/neovim
sudo apt-get install ninja-build gettext cmake unzip curl build-essential

cd $HOME/vault/code/neovim
make CMAKE_BUILD_TYPE=RelWithDebInfo
#debian way
cd build && cpack -G DEB && sudo dpkg -i nvim-linux64.deb
