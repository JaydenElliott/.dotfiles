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
  

  # video
  ffmpeg \
  mediainfo \

  # DE
  xdg-desktop-portal-gnome \
  xdg-desktop-portal

  
# oh-my-zsh
if [ ! -d "$ZSH" ]; then
  mkdir -p $HOME/.config/zsh
  $ZSH/oh-my-zsh.sh || \
   ZSH="$HOME/.config/zsh/oh-my-zsh" sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
fi
    

{{#if desktop}}
sudo pacman -S \
  vlc \
  obsidian

sudo yay -S \
  ticktick
{{/if}}




      
    

if ! command -v docker &> /dev/null; 
then
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
