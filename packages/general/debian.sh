#!/bin/bash

sudo apt install -y \
  # essentials
  zsh \
  git \
  wget \
  curl \
  htop \

  # terminal
  fd-find
  ripgrep

  # video
  ffmpeg
  mediainfo
  

{{#if desktop}}
sudo apt install -y snapd
{{/if}}


# lnav
wget https://github.com/tstack/lnav/releases/download/v0.11.2/lnav-0.11.2.tar.gz --output-file=lnav.tar.gz
tar xvfz lnav.tar.gz
cd lnav
./configure
make
make install



# fzf
 git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install 


# lazydocker
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash


# lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
