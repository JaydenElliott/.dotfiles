#!/bin/bash

sudo pacman -S \
  kitty \
  bless \
  vlc \
  mediainfo-gui  \
  obsidian \
  vivaldi

sudo yay -S \
  ticktick \
  anki \
  tableplus \
  ulauncher

if ! command -v docker &> /dev/null; 
then
sudo pacman -S docker-buildx
# docker
#cd /tmp
#git clone https://aur.archlinux.org/nvidia-container-toolkit.git
#cp $HOME/packages/general/nvidia-container-toolkit-PKGBUILD PKGBUILD
## see https://gitlab.com/nvidia/container-toolkit/container-toolkit/-/issues/17#note_1530784413
#makepkg
#sudo pacman -U ...
#sudo groupadd docker
#sudo usermod -aG docker $USER
#newgrp docker
fi

# ulauncher update .desktop file
#Comment=Application launcher for Linux
#GenericName=Launcher
#Categories=GNOME;GTK;Utility;
#TryExec=ulauncher
#Exec=env WEBKIT_DISABLE_COMPOSITING_MODE=1 GDK_BACKEND=x11 /usr/bin/ulauncher --hide-window
#Icon=ulauncher
#Terminal=false
#Type=Application


gsettings set org.gnome.desktop.interface enable-animations false
