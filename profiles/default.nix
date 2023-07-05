{ lib,
  pkgs,
  home-manager,
  nur,
  pkgs-unstable,
  wolfangaukang,
  ...
} @ opts: rec {
  doomsday = import ./doomsday
    { inherit lib
              pkgs
              pkgs-unstable
              home-manager
              wolfangaukang
              nur;

      inherit (opts) system;
    };

  default = doomsday;
}
