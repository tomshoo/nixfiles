{ config, lib, pkgs, ... }:
let
  extensions = with pkgs.gnomeExtensions; [
    appindicator
    quick-settings-tweaker
    miniview
    blur-my-shell
    caffeine
    clipboard-indicator
    bluetooth-quick-connect
    bluetooth-battery
    cloudflare-warp-quick-settings
    dash-to-dock
    disable-menu-switching
    # (gesture-improvements.override { version = 24; })
    ddterm
    hibernate-status-button
    just-another-search-bar
    legacy-gtk3-theme-scheme-auto-switcher
    maximize-to-empty-workspace
    rounded-corners
    rounded-window-corners
    task-widget
    user-avatar-in-quick-settings
    wifi-qrcode
  ];
in {
  services.xserver = {
    enable = true;
    layout = "us";
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  environment.gnome.excludePackages = with pkgs; [
    gnome-console
    gnome.gnome-music
  ];

  environment.systemPackages = with pkgs;
    [ blackbox-terminal rhythmbox amberol endeavour ] # Non gnome packages
    ++ (with gnome; [ gnome-tweaks gnome-software ]) ++ extensions;

  programs.gnome-terminal.enable = true;
}
