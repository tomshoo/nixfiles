{ config, lib, pkgs, ... }:
let packages = import ../../sysconfig/packages.nix { inherit pkgs; };
in {
  services.xserver = {
    enable = true;
    layout = "us";
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  environment.gnome.excludePackages = with pkgs; [ gnome-console ];

  environment.systemPackages = packages ++ (with pkgs;
    [ blackbox-terminal ] # Non gnome packages
    ++ (with gnome; [ gnome-tweaks gnome-software ])
    ++ (with gnomeExtensions; [ appindicator ]));

  programs.gnome-terminal.enable = true;
}
