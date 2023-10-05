#!/bin/bash
if [[ $DIST == "arch" ]] then
  sudo pacman -S vlc
else if [[ $DIST == "fedora" ]]
  flatpak install flathub org.videolan.VLC
else
  flatpak install flathub org.videolan.VLC
