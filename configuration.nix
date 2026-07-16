{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  ##################################################
  ## SYSTEM
  ##################################################

  networking.hostName = "laptop";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Moscow";

  i18n.defaultLocale = "ru_RU.UTF-8";

  console = {
    font = "Lat2-Terminus16";
    keyMap = "ru";
  };

  services.xserver = {
    xkb = {
      layout = "us,ru";
      options = "grp:alt_shift_toggle";
    };
  };

  ##################################################
  ## BOOT
  ##################################################

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  ##################################################
  ## USER
  ##################################################

  users.users.demchkkk = {
    isNormalUser = true;
    initialPassword = "nixos123";

    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
    ];
  };

  security.sudo.extraRules = [
    {
      groups = [ "wheel" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  ##################################################
  ## KDE
  ##################################################

  services.desktopManager.plasma6.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  ##################################################
  ## SOUND
  ##################################################

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  ##################################################
  ## DOCKER
  ##################################################

  virtualisation.docker.enable = true;

  ##################################################
  ## OPENVPN
  ##################################################

  services.openvpn.servers = {};

  ##################################################
  ## PACKAGES
  ##################################################

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [

    ####################
    ## Browsers
    ####################

    firefox

    ####################
    ## Editors
    ####################

    vscode
    kate

    ####################
    ## Terminal
    ####################

    kitty

    ####################
    ## Git
    ####################

    git

    ####################
    ## Kubernetes
    ####################

    kubectl
    kubernetes-helm
    k9s
    # lens  # <- ЗАКОММЕНТИРОВАНО (не скачивается в РФ)

    ####################
    ## VPN
    ####################

    openvpn

    ####################
    ## Docker
    ####################
    docker
    docker-compose

    ####################
    ## KDE apps
    ####################

    dolphin
    konsole
    okular
    gwenview

    ####################
    ## Desktop apps
    ####################

    telegram-desktop

    ####################
    ## Utilities
    ####################

    curl
    wget
    unzip
    zip
    tree
    jq
    yq-go
    ripgrep
    fd
    fzf
    htop
    btop
    fastfetch
  ];

  ##################################################
  ## SSH
  ##################################################

  services.openssh.enable = true;

  ##################################################
  ## NIX
  ##################################################

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  ##################################################
  ## VERSION
  ##################################################

  system.stateVersion = "24.11";
}