{ lib,
  pkgs,
  home-manager,
  nur,
  pkgs-unstable,
  ...
} @ opts: rec {
  doomsday = import ./doomsday
    { inherit lib
              pkgs
              pkgs-unstable
              home-manager
              nur;

      inherit (opts) system nixosModules;
    };

  default = doomsday;
}
