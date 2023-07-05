{ config,
  pkgs,
  pkgs-unstable,
  ...
} : let
  nerdfonts = pkgs.nerdfonts.override
    { fonts = [ "JetBrainsMono" "Hack" "FiraCode" ];
    };

in
{ imports =
    [ ../../../system
      ./hardware-configuration.nix
      ./users.nix
    ];

  networking.hostName = "doomsday";

  fonts =
    { fonts              = [ nerdfonts config.nur.repos.rewine.ttf-ms-win10 ];
      fontDir.enable     = true;
      enableDefaultFonts = true;

      fontconfig.defaultFonts.monospace = [ "Hack Nerd Font" ];
    };

  programs.zsh.enable = true;
  environment =
    { shells         = with pkgs; [ zsh ];
      systemPackages = with pkgs;
        [ neovim
          file
          wget
          nix-index
          ntfs3g
          lm_sensors
          pkgs-unstable.cloudflare-warp
        ];

      variables.NIXPKGS_ALLOW_UNFREE = "1";
    };

  virtualisation =
    { docker.enable = true;
      waydroid.enable = true;
      lxd.enable = true;
    };
}
