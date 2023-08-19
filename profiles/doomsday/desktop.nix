{ pkgs,
  pkgs-unstable,
  ...
} : let
  extensions = with pkgs.gnomeExtensions;
    [ appindicator
      quick-settings-tweaker
      blur-my-shell
      caffeine
      clipboard-indicator
      dotspaces
      just-another-search-bar
      maximize-to-empty-workspace
      rounded-window-corners
      disable-menu-switching
      task-widget
      dash-to-dock
      gesture-improvements
    ];
in
{ services.xserver =
    { enable = true;
      layout = "us";
      displayManager.defaultSession = "gnome";
      desktopManager.gnome.enable = true;
      displayManager.gdm =
        { enable = true;
          wayland = true;
        };
    };

  services.udev.packages = with pkgs.gnome;
    [ gnome-settings-daemon
    ];

  environment.gnome.excludePackages = with pkgs;
    [ gnome-console
      gnome.gnome-music
      gnome.totem
    ];

  environment.systemPackages =
    (with pkgs; [
      pkgs-unstable.blackbox-terminal
      amberol
      endeavour
      mpv
      gnome.gnome-tweaks
    ]) ++ extensions;

  xdg.portal.enable = true;
  programs.gnome-terminal.enable = true;
}
