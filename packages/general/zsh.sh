#!/bin/bash

sudo apt install -y zsh
sudo dnf install -y zsh

$ZSH/oh-my-zsh.sh || \
  sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"



