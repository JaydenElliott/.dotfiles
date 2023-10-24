#!/bin/bash

sudo pacman -S \
  # essentials
  zsh \
  git \
  wget \
  curl \
  htop \
  xclip \

  # terminal
  lnav \
  fd \
  ripgrep \
  lazydocker \
  lazygit \
  sad
  

  # video
  ffmpeg \
  mediainfo \
  mpv \

  # DE
  xdg-desktop-portal-gnome \
  xdg-desktop-portal \

  # compilation
  clang \
  gcc \
  protoc \

  # rust
  nasm \
  gst-rtsp-server

  
# oh-my-zsh
if [ ! -d "$ZSH" ]; then
  mkdir -p $HOME/.config/zsh
  $ZSH/oh-my-zsh.sh || \
   ZSH="$HOME/.config/zsh/.oh-my-zsh" sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$ZSH/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-$ZSH}/custom}/plugins/zsh-completions
fi
    

{{#if desktop}}
sudo pacman -S \
  kitty \
  bless \
  vlc \
  mediainfo-gui  \
  obsidian \
  vivaldi \

  xorg-xrdb \
  polybar

sudo yay -S \
  gnome-browser-connector \
  ticktick \
  anki \
  tableplus \
  ulauncher \
  spotify

# ulauncher update .desktop file
#Comment=Application launcher for Linux
#GenericName=Launcher
#Categories=GNOME;GTK;Utility;
#TryExec=ulauncher
#Exec=env WEBKIT_DISABLE_COMPOSITING_MODE=1 GDK_BACKEND=x11 /usr/bin/ulauncher --hide-window
#Icon=ulauncher
#Terminal=false
#Type=Application

{{/if}}




      
    

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

gsettings set org.gnome.desktop.interface enable-animations false
