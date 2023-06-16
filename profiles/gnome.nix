{ pkgs, ... } :
let extensions = with pkgs.gnomeExtensions;
  [ appindicator
    quick-settings-tweaker
    blur-my-shell
    caffeine
    clipboard-indicator
    dash-to-dock
    just-another-search-bar
    maximize-to-empty-workspace
    rounded-window-corners
  ];
in {
  services.xserver = {
    enable = true;
    layout = "us";
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  services.udev.packages = with pkgs.gnome; [ gnome-settings-daemon ];

  environment.gnome.excludePackages = with pkgs; [
    gnome-console
    gnome.gnome-music
  ];

  environment.systemPackages = with pkgs;
  [ blackbox-terminal
    amberol
    endeavour
    gnome.gnome-tweaks
  ] ++ extensions;

  programs.gnome-terminal.enable = true;
}
