#!/bin/bash
if ! command -v lazydocker &> /dev/null
then
  curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
fi
