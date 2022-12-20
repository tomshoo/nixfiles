{ config, lib, pkgs, ... }:
let packages = import ../packages.nix { inherit pkgs; };
in {
  services.xserver = {
    enable = true;
    layout = "us";
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  environment.gnome.excludePackages = with pkgs; [ gnome-console ];

  environment.systemPackages = packages # Default packages
    ++ (with pkgs;
      (with gnome; [ gnome-tweaks gnome-software ])
      ++ (with gnomeExtensions; [ appindicator ]));

  programs.gnome-terminal.enable = true;

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ALL = "en_US.UTF-8";
      LC_NAME = "en_IN";
      LC_ADDRESS = "en_IN";
      LC_MEASUREMENT = "en_IN";
      LC_PAPER = "en_IN";
      LC_TIME = "en_IN";
      LC_IDENTIFICATION = "en_IN";
      LC_NUMERIC = "en_IN";
      LC_TELEPHONE = "en_IN";
    };
  };
}
