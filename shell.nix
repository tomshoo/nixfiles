{ pkgs ? import <nixpkgs> {  } }: pkgs.mkShell  {
    name = "flake shell";
    description = "...";
    buildInputs = with pkgs; [
      nixFlakes
    ];

    shellHook = "echo loaded nix flake shell";
  }
