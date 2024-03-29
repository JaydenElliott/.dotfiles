#!/bin/bash

if [ ! -d "$ZSH" ]; then
  mkdir -p $HOME/.config/zsh
  $ZSH/oh-my-zsh.sh || \
   ZSH="$HOME/.config/zsh/.oh-my-zsh" sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$ZSH/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-$ZSH/custom}/plugins/zsh-completions
fi
