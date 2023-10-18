#!/bin/bash

# lazy docker
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash


#!/bin/bash
if ! command -v kitty &> /dev/null
then
  curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
fi
