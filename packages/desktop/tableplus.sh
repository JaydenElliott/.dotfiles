#!/bin/bash
wget -qO - https://deb.tableplus.com/apt.tableplus.com.gpg.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/tableplus-archive.gpg > /dev/null
sudo add-apt-repository "deb [arch=amd64] https://deb.tableplus.com/debian/22 tableplus main"
sudo apt update
sudo apt install tableplus

sudo rpm -v --import https://yum.tableplus.com/apt.tableplus.com.gpg.key
sudo dnf config-manager --add-repo https://yum.tableplus.com/rpm/x86_64/tableplus.repo
sudo dnf install tableplus
