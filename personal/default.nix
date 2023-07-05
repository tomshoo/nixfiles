{ pkgs,
  pkgs-unstable,
  config,
  ...
} @ opts: let
  inherit (opts) username;
  datadir = config.xdg.dataHome;
in {
  imports = [ ./applications ];

  home.username      = username;
  home.homeDirectory = "/home/${username}";

  home.sessionVariables = {
    TERM               = "xterm-256color";
    WINIT_UNIX_BACKEND = "x11";
    MOZ_ENABLE_WAYLAND = "1";
    LD_LIBRARY_PATH    = "${pkgs.zlib}/lib:${pkgs.sqlite.out}/lib:$LD_LIBRARY_PATH";
    EDITOR             = "nvim";
    MANPAGER           = "sh -c 'col -bx | bat -l man -p'";
  };

  home.file."${datadir}/flatpak/overrides/global".text =
    ''
    [Context]
    filesystem=${datadir}/fonts:ro;xdg-config/gtk-3.0;xdg-config/gtk-40.
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
      firefox
      git
    ];

  services.lorri.enable        = true;
  programs.home-manager.enable = true;

  home.stateVersion = "23.05";
}
