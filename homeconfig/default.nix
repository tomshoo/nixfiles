{ config, pkgs, ... }:

{
  imports = [
    ../applications/home/editors # Configure editors
    ../applications/home/vcs # Configure Version Control Systems
    ../applications/home/shell # Configure the shell
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "tomshoo";
  home.homeDirectory = "/home/tomshoo";

  home.sessionVariables = {
    TERM = "xterm-256color";
    WINIT_UNIX_BACKEND = "x11";
    MOZ_ENABLE_WAYLAND = 1;
    LD_LIBRARY_PATH =
      "${pkgs.zlib}/lib:${pkgs.sqlite.out}/lib:$LD_LIBRARY_PATH";
  };

  home.file.".local/share/flatpak/overrides/global".text = ''
    [Context]
    filesystem=~/.local/share/fonts:ro;xdg-config/gtk-3.0;xdg-config/gtk-4.0
  '';

  home.packages = with pkgs; [
    neovide
    obsidian
    tilix
    go
    unzip
    fzf
    zoxide
    gcc
    adw-gtk3
    libreoffice-fresh
    sqlite
    qbittorrent

    wl-clipboard

    ((emacsPackagesFor emacs-gtk).emacsWithPackages
      (epkgs: with epkgs; [ vterm ]))

    (python310.withPackages
      (python-packages: with python-packages; [ pip ipython ]))
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";
}
