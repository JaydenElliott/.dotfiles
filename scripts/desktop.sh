#!/bin/bash

cd /tmp

# Kitty terminal
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# Chrome
sudo apt-get install libxss1 libappindicator1 libindicator7
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome*.deb
# sudo apt-get install -f 

# VLC
sudo snap install vlc

# Obsidian
wget https://github.com/obsidianmd/obsidian-releases/releases/download/v1.4.5/Obsidian-1.4.5.AppImage
chmod u+x ./Obsidian-1.4.5.AppImage
./Obsidian-1.4.5.AppImage


# TickTick
wget https://d2atcrkye2ik4e.cloudfront.net/download/linux/linux_deb_x64/ticktick-1.0.80-amd64.deb
sudo apt install ./ticktick-1.0.80-amd64.deb


# Vscode
wget -c https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64 -O vscode.deb
sudo apt install ./vscode.deb

# TablePlus
wget -qO - https://deb.tableplus.com/apt.tableplus.com.gpg.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/tableplus-archive.gpg > /dev/null
sudo add-apt-repository "deb [arch=amd64] https://deb.tableplus.com/debian/22 tableplus main"
sudo apt update
sudo apt install tableplus


# MediaInfo GUI
apt-get install mediainfo-gui

# Docker
curl https://get.docker.com | sh \
  && sudo systemctl --now enable docker

[ ! command -v docker &> /dev/null ] && https://get.docker.com | sh && sudo systemctl --now enable docker
[ ! command -v lazydocker &> /dev/null ] && curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

if [ ! command -v nvidia-container-toolkit &> /dev/null ] then
  distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
    && curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
    && curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
  sudo apt-get update
  sudo apt-get install -y nvidia-container-toolkit
  sudo nvidia-ctk runtime configure --runtime=docker --set-as-default
  sudo systemctl restart docker
fi


