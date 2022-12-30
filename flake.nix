{
  description = "Configuration flake for building my NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";

    nur.url = "github:nix-community/NUR";

    doom-emacs.url = "github:/nix-community/nix-doom-emacs";

    home-manager = {
      url = "github:/nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:vaxerski/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      username = "tomshoo";
      userdesc = "Shubhanshu Tomar";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = import ./hosts {
        inherit system pkgs username lib userdesc;
        inherit (inputs) nur home-manager; # Providers
        inherit (inputs) doom-emacs hyprland; # Overlays/Extensions
      };
    };
}
