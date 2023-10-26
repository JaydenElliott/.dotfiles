#!/bin/bash

# essentials
apt install -y \
  zsh \
  git \
  wget \
  curl \
  htop \
  xclip

# terminal
apt install -y \
  fd-find \
  ripgrep \
  delta 

# lsp && compilers
apt install -y \
  build-essential \
  clang \
  node \
  npm 
   
# video
apt install -y \
  ffmpeg \
  mediainfo 

# other
./packages/oh-my-zsh.sh
./packages/fzf.sh
./packages/rust.sh
./packages/neovim.sh
./packages/docker-arch.sh
./packages/lnav.sh

ln -s $(which fdfind) ~/.local/bin/fd
