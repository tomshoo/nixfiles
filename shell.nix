{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
  __impure = true;
  name = "flake shell";
  description = "...";
  buildInputs = with pkgs; [ nixFlakes ];

  HISTFILE = ".shell_history";

  shellHook = "echo loaded nix flake shell";
}
