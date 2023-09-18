#!/bin/bash
source ./utils.sh

# rustup/cargo
is_installed rustup || curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# lazydocker
is_installed lazydocker || curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

# oh-my-zsh
stat $ZSH/oh-my-zsh.sh || sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

