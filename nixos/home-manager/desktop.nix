
{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Gnome
    xdg-desktop-portal-gnome
    xdg-desktop-portal 
    gnome.gnome-tweaks

    # Application launcher
    ulauncher
    
    # Browsers
    firefox
    
    spotify
    steam
    discord
  ];
}
