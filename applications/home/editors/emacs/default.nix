{ pkgs, lib, ... }@opts:
let inherit (opts) doom-emacs;
in {
  imports = [ doom-emacs.hmModule ];

  programs.doom-emacs = {
    enable = false;
    doomPrivateDir = ./doom.d;
  };
}
