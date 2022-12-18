{ pkgs, nur, home-manager, ... }@opts:
let
  inherit (opts) lib;
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

    specialArgs = {
      inherit (opts) system username;
      inherit pkgs;
    };
  };
  plasma = lib.nixosSystem {
    inherit modules;

    specialArgs = {
      inherit (opts) system username;
      inherit pkgs;
      profile = "plasma.nix";
    };
  };
}
