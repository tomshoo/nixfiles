{ pkgs,
  pkgs-unstable,
  ...
} @ opts: {
  imports = [ ./applications ];

  home.username = opts.username;
  home.homeDirectory = "/home/${opts.username}";

  home.sessionVariables =
    { TERM = "xterm-256color";
      WINIT_UNIX_BACKEND = "x11";
      MOZ_ENABLE_WAYLAND = "1";
      LD_LIBRARY_PATH = "${pkgs.zlib}/lib:${pkgs.sqlite.out}/lib:$LD_LIBRARY_PATH";
    };

  home.file.".local/share/flatpak/overrides/global".text =
    ''
    [Context]
    filesystem=~/.local/share/fonts:ro;xdg-config/gtk-3.0;xdg-config/gtk-40.
    '';

  home.packages = with pkgs;
    [ unzip
      zoxide
      gcc
      adw-gtk3
      qbittorrent
      exa
      fzf
      ripgrep
      bat
      fd
      pfetch
      pkgs-unstable.glab
    ];

  services.lorri.enable = true;
  programs.home-manager.enable = true;

  home.stateVersion = "23.05";
}
