{ config, pkgs, ... } : {
  imports =
    [ ./hardware-configuration.nix
      ./sudo.nix
      ./flatpaks.nix
      ./nvidia.nix
      ./users.nix
    ];

  boot.loader.efi = {
    efiSysMountPoint = "/boot/efi";
    canTouchEfiVariables = true;
  };

  boot.loader.grub = {
    enable = true;
    devices = [ "nodev" ];
    efiSupport = true;
    useOSProber = true;
    configurationLimit = 5;
    gfxmodeEfi = "1920x1080";
  };

  networking.hostName = "doomsday";
  networking.networkmanager.enable = true;
  networking.nameservers = [ "1.1.1.1" "1.1.0.1" ];

  time = {
    timeZone = "Asia/Kolkata";
    hardwareClockInLocalTime = true;
  };

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  services.printing.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  fonts = {
    fonts = [ pkgs.nerdfonts config.nur.repos.rewine.ttf-ms-win10 ];
    fontDir.enable = true;
    enableDefaultFonts = true;
    fontconfig.defaultFonts.monospace = [ "RobotoMono Nerd Font" ];
  };

  environment = {
    shells = with pkgs; [ zsh ];

    variables = {
      NIXPKGS_ALLOW_UNFREE = "1";
    };

    systemPackages = with pkgs; 
      [ neovim
        wget
        nix-index
        ntfs3g
        lm_sensors
      ];
  };

  programs.zsh.enable = true;

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features =
        [ "nix-command"
          "flakes"
          "impure-derivations"
        ];
      };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixFlakes;
  };

  virtualisation.docker.enable = true;

  system.autoUpgrade = {
    allowReboot = true;
    enable = true;
  };

  system.stateVersion = "23.05";
}
