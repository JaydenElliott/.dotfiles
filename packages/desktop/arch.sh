#!/bin/bash

sudo pacman -S \
  kitty \
  bless \
  vlc \
  mediainfo-gui  \
  obsidian \
  vivaldi

sudo yay -S \
  ticktick \
  anki \
  tableplus \
  ulauncher



# ulauncher update .desktop file
#Comment=Application launcher for Linux
#GenericName=Launcher
#Categories=GNOME;GTK;Utility;
#TryExec=ulauncher
#Exec=env WEBKIT_DISABLE_COMPOSITING_MODE=1 GDK_BACKEND=x11 /usr/bin/ulauncher --hide-window
#Icon=ulauncher
#Terminal=false
#Type=Application


gsettings set org.gnome.desktop.interface enable-animations false
