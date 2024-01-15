#!/bin/bash

if ! command -v docker &> /dev/null; 
then
#sudo pacman -S docker-buildx
# docker
#cd /tmp
#git clone https://aur.archlinux.org/nvidia-container-toolkit.git
#cp $HOME/packages/general/nvidia-container-toolkit-PKGBUILD PKGBUILD
## see https://gitlab.com/nvidia/container-toolkit/container-toolkit/-/issues/17#note_1530784413
# may need to run sudo pacman -U nvidia-container-toolkit-base-1.13.5-1-x86_64.pkg.tar.zst --overwrite /etc/nvidia-container-runtime/config.toml --overwrite /usr/bin/nvidia-ctk --overwrite /usr/share/doc/nvidia-container-toolkit-base/changelog.Debian.gz --overwrite /usr/share/doc/nvidia-container-toolkit-base/copyright
#makepkg
#sudo pacman -U ...
#sudo groupadd docker
#sudo usermod -aG docker $USER
#newgrp docker
fi
