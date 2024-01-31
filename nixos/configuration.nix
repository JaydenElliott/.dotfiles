{ config, pkgs, ... }:
{
  imports = [
      ./hardware-configuration.nix
    ];

	nix.settings.experimental-features = [ "nix-command" "flakes" ];

  users.users.jaydenelliott = {
    isNormalUser = true;
    description = "jaydenelliott";
    extraGroups = [ "networkmanager" "wheel" ];
  };
  

  # Packages
  nixpkgs.config.allowUnfree = true;
  environment = {
    systemPackages = with pkgs; [
      git
      wget
      curl
      neovim
      vim
    ]; 
    
    variables = {
      EDITOR = "nvim"; 
      ZSH = "${pkgs.oh-my-zsh}/share/oh-my-zsh/";
    };
  };
  virtualisation.docker.enable = true;
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
        enable = true; 
        theme = "robbyrussell";
        plugins = [
          "git"
        ];
      };
    };

  users.users.jaydenelliott.shell = pkgs.zsh;


  # Services
  services.openssh.enable = true;

  
  # Hardware
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    nvidiaSettings = true;
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "nixos"; 
  networking.networkmanager.enable = true;

  
  # Printing
  services.printing.enable = true;


  # Sound
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  
  
  # Timezone
  time.timeZone = "Australia/Sydney";
  i18n.defaultLocale = "en_AU.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "au";
    xkbVariant = "";
  };

  

  system.stateVersion = "23.11";

}
