{ lib,
  pkgs,
  pkgs-unstable,
  home-manager,
  wolfangaukang,
  nur,
  ...
} @ opts : let
  username    = "tomshoo";
  description = "Shubhanshu Tomar";
in lib.nixosSystem {
  modules =
    [ nur.nixosModules.nur
      ./system/configuration.nix
      ./desktop.nix

      wolfangaukang.nixosModules.cloudflare-warp
      home-manager.nixosModules.home-manager {
        home-manager = {
          extraSpecialArgs =
            { inherit username pkgs-unstable;
            };

          useGlobalPkgs = true;
          useUserPackages = true;

          users.${username}.imports =
            [ ../../personal
            ];
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
