{ pkgs, nur, home-manager, ... }@opts:
let inherit (opts) lib username;
in {
  hyprland = lib.nixosSystem {
    modules = [

      opts.hyprland.nixosModules.default

      nur.nixosModules.nur
      ../sysconfig
      ../profiles/hyprland

      home-manager.nixosModules.home-manager
      {
        home-manager = {
          extraSpecialArgs = { inherit (opts) doom-emacs; };
          useGlobalPkgs = true;
          useUserPackages = true;
          users.${username}.imports = [
            ../home/${username}
            ../profiles/hyprland/home.nix # Hyprland specific
          ];
        };
      }
    ];

    specialArgs = {
      inherit (opts) system username;
      inherit pkgs;
    };
  };
  default = lib.nixosSystem {
    # inherit modules;
    modules = [
      nur.nixosModules.nur
      ../sysconfig
      ../profiles/gnome

      home-manager.nixosModules.home-manager
      {
        home-manager = {
          extraSpecialArgs = { inherit (opts) doom-emacs; };
          useGlobalPkgs = true;
          useUserPackages = true;
          users.${username}.imports = [ ../home/${username} ];
        };
      }
    ];

    specialArgs = {
      inherit (opts) system username;
      inherit pkgs;
    };
  };
  plasma = lib.nixosSystem {
    # inherit modules;
    modules = [
      nur.nixosModules.nur
      ../sysconfig
      ../profiles/plasma

      home-manager.nixosModules.home-manager
      {
        home-manager = {
          extraSpecialArgs = { inherit (opts) doom-emacs; };
          useGlobalPkgs = true;
          useUserPackages = true;
          users.${username}.imports = [ ../home/${username} ];
        };
      }
    ];

    specialArgs = {
      inherit (opts) system username;
      inherit pkgs;
    };
  };
}
