{ description = "Configuration flake for the system";

  inputs = {
    nixpkgs.url          = "github:nixos/nixpkgs/nixos-23.05";
    nur.url              = "github:nix-community/NUR";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager         = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self,
              nixpkgs,
              nixpkgs-unstable,
              ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgconfig =
      { config.allowUnfree = true;
        localSystem.system = system;
      };

    pkgs          = import nixpkgs (pkgconfig);
    pkgs-unstable = import nixpkgs-unstable (pkgconfig);

    inherit (nixpkgs) lib;
  in 
  rec { nixosConfigurations = import ./profiles
      { inherit lib pkgs pkgs-unstable system;
        inherit (inputs) home-manager nur;
        inherit nixosModules;
      };

    nixosModules = import ./modules;
  };
}
