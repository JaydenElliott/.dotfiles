
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

    # HYPRLAND
    # see bindings and ipc https://hyprland.org - for nice settings
    # plugins: https://github.com/hyprland-community/awesome-hyprland 
    # and hall of fame https://hyprland.org/hall_of_fame/
    # great dotfiles https://github.com/fufexan/dotfiles
  ];
}
