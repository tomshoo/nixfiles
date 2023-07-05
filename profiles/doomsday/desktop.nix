{ pkgs,
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
    ];

  environment.systemPackages =
    extensions
    ++(with pkgs;
      [ blackbox-terminal
        amberol
        endeavour
        gnome.gnome-tweaks
      ]);

  xdg.portal.enable = true;
  programs.gnome-terminal.enable = true;
}
