{ pkgs,
  pkgs-unstable,
  lib,
  home-manager,
  nur,
  ...
} @ opts : let
  username = "tomshoo";
  description = "Shubhanshu Tomar";
in lib.nixosSystem {
  modules =
    [ nur.nixosModules.nur
      ../../system
      ./desktop.nix

      home-manager.nixosModules.home-manager {
        home-manager = {
          extraSpecialArgs = { inherit username pkgs-unstable; };
          useGlobalPkgs = true;
          useUserPackages = true;
          users.${username}.imports = [ ../../personal ];
        };
      }
    ];

  specialArgs = {
    inherit pkgs
            pkgs-unstable
            username
            description;

    inherit (opts) system;
  };
}
