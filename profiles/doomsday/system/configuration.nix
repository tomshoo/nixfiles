{ config,
  pkgs,
  ...
} : let
  nerdfonts = pkgs.nerdfonts.override
    { fonts =
        [ "RobotoMono"
          "JetBrainsMono"
          "Hack"
          "FiraCode"
        ];
    };

in
{ imports =
    [ ../../../system
      ./hardware-configuration.nix
      ./users.nix
    ];

  networking.hostName = "doomsday";

  fonts =
    { fonts = [ nerdfonts config.nur.repos.rewine.ttf-ms-win10 ];
      fontDir.enable = true;
      enableDefaultFonts = true;
      fontconfig.defaultFonts.monospace = [ "RobotoMono Nerd Font" ];
    };

  programs.zsh.enable = true;
  environment =
    { shells = with pkgs; [ zsh ];
      variables.NIXPKGS_ALLOW_UNFREE = "1";

      systemPackages = with pkgs;
        [ neovim
          file
          wget
          nix-index
          ntfs3g
          lm_sensors
        ];
    };

  virtualisation.docker.enable = true;
}
