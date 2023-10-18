#!/bin/bash

sudo apt install -y \
  # essentials
  zsh \
  git \
  wget \
  curl \
  htop \
  xclip \

  # terminal
  fd-find \
  ripgrep \

  # video
  ffmpeg \
  mediainfo \


# oh-my-zsh
if [ ! -d "$ZSH" ]; then
  mkdir -p $HOME/.config/zsh
  $ZSH/oh-my-zsh.sh || \
   ZSH="$HOME/.config/zsh/oh-my-zsh" sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
fi


# lnav
wget https://github.com/tstack/lnav/releases/download/v0.11.2/lnav-0.11.2.tar.gz --output-file=lnav.tar.gz
tar xvfz lnav.tar.gz
cd lnav
./configure
make
make install


# rust
if ! command -v rustup &> /dev/null
then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi


# neovim
if ! command -v nvim &> /dev/null; 
then
  cargo install --git https://github.com/MordechaiHadad/bob.git
  bob use stable
  
  cargo install --locked --all-features \
    --git https://github.com/ms-jpq/sad --branch senpai
fi


# fzf
if ! command -v fzf &> /dev/null; 
then
   git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install 
fi



# lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo apt install lazygit /usr/local/bin

{{#if desktop}}
# lazydocker
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

sudo apt install mediainfo-gui

./docker.sh

# kitty
if ! command -v kitty &> /dev/null
then
  curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
fi
{{/if}}
