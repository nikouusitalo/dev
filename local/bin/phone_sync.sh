#!/usr/bin/env bash

# dep rsync simple-mtp
PHONE_DIR="$HOME/phone/SD-kortti: Samsung/media"
PC_DIR="/media/media/"
# connect phone mount 
#command simple-mtp --device 1 ~/cell/
# check change and copy dir
 rsync -avu "$PC_DIR" "$PHONE_DIR"
#command rsync -avu "$PHONE_DIR" "$PC_DIR"
# use rsynt to copy dir
# unmount phone 
#unmount_phone() {
 #   fusermount -u ~/cell/
#}
