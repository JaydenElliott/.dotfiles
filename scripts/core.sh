#!/bin/bash

# rust
[ ! command -v rustup &> /dev/null ] && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# oh-:y-zsh
[ ! -f "$ZSH/oh-my-zsh.sh" ] && sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


