{ config, pkgs, ... }:

{
  imports = [
    ./dconf.nix
    ./desktop.nix
  ];
  
  home.username = "jaydenelliott";
  home.homeDirectory = "/home/jaydenelliott";

  home.stateVersion = "23.11"; 

  home.packages = with pkgs; [
    # essentials
    zsh
    git
    wget
    curl
    xh # curl replacement
    htop # TODO: replace later
    xclip
    tealdeer
    

    # terminal
    fd
    ripgrep
    fzf
    lazydocker
    lazygit
    sad
    lnav
    dotter
    kitty


    # compilation and coding
    gcc
    protobuf
    nasm 
    nodejs

    # video
    ffmpeg
    mediainfo
    mpv 
    gst_all_1.gst-rtsp-server
  ];

  programs = {
    home-manager.enable = true;
    
    git = {
    enable = true;
    userName = "jaydenelliott";
    userEmail = "jayden.elliott@outlook.com";
    };

    # TODO: setup later, thisis nicer than htop
    btop = {
      enable = true;
      settings = {
        color_theme = "gruvbox_dark_v2";
        vim_keys = true;
      };
    };


  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      # gtk-theme = "Catppuccin-Mocha-Standard-Blue-Dark";
      # cursor-theme = "Bibata-Modern-Ice";
      # icon-theme = "Fluent-dark";
    };
  };

  

  # TODO: migrate dotfiles to here, as it can run on any distro!

  home.shellAliases = {
    update = "sudo nixos-rebuild switch";
  };





  home.sessionVariables = {
    EDITOR = "nvim";
  };

}
