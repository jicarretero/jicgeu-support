#!/bin/bash

# Things to install:
# - openssh        -- To remotely access the server
# - xorg and xf86-video-intel (which I need to run my xwindow session)
# - lightdm and lightdm-gtk-greeter as lightdm default greeter
# - Some other software I'll need to "rice" my i3wm 
# 
pacman -S xorg xorg-xinit xorg-xinput i3-gaps i3blocks i3status xf86-video-intel lightdm rofi feh dunst picom jq dmenu lightdm-gtk-greeter kitty firefox xterm openssh firefox kitty

# Enable and start my ssh server
systemctl enable openssh
systemctl start openssh

# Enable Blackarch repo
cd /tmp
curl -O https://blackarch.org/strap.sh
chmod +x strap.sh
./strap.sh

# Install AUR Helper -- yay, apru, etc would be ok
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# After installing, lightdm could be enabled / started
sudo systemctl enable lightdm

# Set Keyboardlayout to spanish
cat << EOT > /etc/X11/xorg.conf.d/00-keyboard.conf
Section "InputClass"
        Identifier "system-keyboard"
        MatchIsKeyboard "on"
        Option "XkbLayout" "es"
EndSection
EOT

# Start lightdm
sudo systemctl start lightdm

