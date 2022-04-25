#!/bin/bash

# Things to install:
# - openssh        -- To remotely access the server
# - xorg and xf86-video-intel (which I need to run my xwindow session)
# - lightdm and lightdm-gtk-greeter as lightdm default greeter
# - Some other software I'll need to "rice" my i3wm 
# 
pacman -S xorg xorg-xinit xorg-xinput i3-gaps i3blocks i3status xf86-video-intel lightdm rofi feh dunst picom jq dmenu lightdm-gtk-greeter kitty firefox xterm openssh

# Enable and start my ssh server
systemctl enable openssh
systemctl start openssh

# After installing, lightdm could be enabled / started
sudo systemctl lightdm enable
sudo systemctl lightdm start
