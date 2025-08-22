#!/bin/bash

TV_STATUS=$(swaymsg -t get_outputs | jq -r '.[] | select(.name == "HDMI-A-1") | .active')

if [[ "$TV_STATUS" == "false" ]]; then
    swaymsg output DP-1 disable
    swaymsg output DP-3 disable
    swaymsg output HDMI-A-1 enable
    pactl set-default-sink alsa_output.pci-0000_0a_00.1.hdmi-stereo-extra3.3 	
else
    swaymsg output HDMI-A-1 disable
    swaymsg output DP-1 enable
    swaymsg output DP-3 enable
    pactl set-default-sink alsa_output.usb-Focusrite_Scarlett_4i4_USB_D83B34V9C0CBC5-00.pro-output-0
fi
