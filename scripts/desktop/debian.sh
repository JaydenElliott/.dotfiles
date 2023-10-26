#!/bin/bash

sudo apt install -y \
  mediainfo-gui

# lazy docker
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash


# table plus
wget https://github.com/obsidianmd/obsidian-releases/releases/download/v1.4.5/Obsidian-1.4.5.AppImage
chmod u+x ./Obsidian-1.4.5.AppImage
./Obsidian-1.4.5.AppImage


# TablePlus
wget -qO - https://deb.tableplus.com/apt.tableplus.com.gpg.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/tableplus-archive.gpg > /dev/null
sudo add-apt-repository "deb [arch=amd64] https://deb.tableplus.com/debian/22 tableplus main"
sudo apt update
sudo apt install tableplus


# kitty
if ! command -v kitty &> /dev/null
then
  curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
fi


flatpak install flathub \
  com.ticktick.TickTick \
  org.videolan.VLC


# bless
cd /tmp
meson setup build (-Dopt=val --buildtype=type ...)
git clone https://github.com/afrantzis/bless
ninja -C build
sudo ninja -C build install

# anki 
sudo apt install libxcb-xinerama0 libxcb-cursor0
tar xaf Downloads/anki-2.1.XX-linux-qt6.tar.zst
cd anki-2.1.XX-linux-qt6
sudo ./install.sh
