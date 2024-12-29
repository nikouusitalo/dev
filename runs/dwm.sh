#!/usr/bin/env bash

git clone -b dev https://github.com/nikouusitalo/dwm.git  $HOME/vault/code/dwm
cd $HOME/vault/code/dwm
make clean install
