#!/bin/bash

wget https://downloads.vivaldi.com/stable/vivaldi-stable_6.2.3105.51-1_amd64.deb -O vivaldi.deb
sudo apt install  ./vivaldi.deb

wget https://downloads.vivaldi.com/stable/vivaldi-stable-6.2.3105.51-1.x86_64.rpm -O vivaldi.rpm
sudo dnf install ./vivaldi.rpm
