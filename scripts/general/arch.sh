#!/bin/bash

# essentials
sudo pacman -S \
  zsh \
  git \
  wget \
  curl \
  htop \
  xclip

# terminal
sudo pacman -S \
  lnav \
  fd \
  ripgrep \
  fzf \
  lazydocker \
  lazygit \
  sad 

# DE
sudo pacman -S \
  xdg-desktop-portal-gnome \
  xdg-desktop-portal \

# compilation
sudo pacman -S \
  clang \
  gcc \
  protoc \
  node \
  npm

# rust
sudo pacman -S \
  nasm \
  gst-rtsp-server

# video
sudo pacman -S \
  ffmpeg \
  mediainfo \
  mpv 
  
# other
./packages/oh-my-zsh.sh
./packages/rust.sh
./packages/neovim.sh
./packages/docker-arch.sh
./packages/lnav.sh
