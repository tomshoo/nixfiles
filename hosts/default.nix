{ nixpkgs, nur, home-manager, ... }@opts:
let
  lib = nixpkgs.lib;
  modules = [
    nur.nixosModules.nur
    ../sysconfig

    home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.tomshoo.imports = [ ../homeconfig ];
      };
    }
  ];
in {
  default = lib.nixosSystem {
    inherit modules;

    specialArgs = { inherit (opts) system username; };
  };
  plasma = lib.nixosSystem {
    inherit modules;

    specialArgs = {
      inherit (opts) system username;
      profile = "plasma.nix";
    };
  };
}
