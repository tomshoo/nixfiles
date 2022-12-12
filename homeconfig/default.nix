{ config, pkgs, ... }:

{
  imports = [ ./neovim/init.nix ];
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "tomshoo";
  home.homeDirectory = "/home/tomshoo";

  home.sessionVariables = {
    TERM = "screen-256color";
    WINIT_UNIX_BACKEND = "x11";
    MOZ_ENABLE_WAYLAND = 1;
    LD_LIBRARY_PATH =
      "${pkgs.zlib}/lib:${pkgs.sqlite.out}/lib:$LD_LIBRARY_PATH";
  };

  home.packages = with pkgs; [
    neovide
    tilix
    go
    unzip
    nerdfonts
    ripgrep
    nodejs
    rustup
    rust-analyzer
    adw-gtk3
    gnome.gnome-tweaks
    libreoffice-fresh
    sqlite
    qbittorrent

    wl-clipboard

    ((emacsPackagesFor emacs-gtk).emacsWithPackages
      (epkgs: with epkgs; [ vterm ]))

    (python310.withPackages
      (python-packages: with python-packages; [ pip requests ipython pipenv ]))
  ];

  programs.gh = {
    enable = true;
    enableGitCredentialHelper = true;
  };

  programs.git = {
    enable = true;
    userName = "Shubhanshu Tomar";
    userEmail = "tomarshubhanshu@protonmail.ch";
    extraConfig = {
      init.defaultBranch = "master";
      url = { "https://github.com/" = { insteadOf = [ "gh:" "github:" ]; }; };
    };
  };

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      export TERM=screen-256color
      nix-index-fetch() {
        filename="index-$(uname -m)-$(uname | tr A-Z a-z)"
        [ ! -d ~/.cache/nix-index ] && mkdir ~/.cache/nix-index
        pushd ~/.cache/nix-index/ || return 1
        wget -q -N https://github.com/Mic92/nix-index-database/releases/latest/download/$filename
        ln -f $filename files
        popd || return 1
      }
    '';
    shellAliases = { doom = "~/.emacs.d/bin/doom"; };
  };

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
