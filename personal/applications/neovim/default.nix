{ pkgs,
  pkgs-unstable,
  ...
}: let
  tsserver   = pkgs.nodePackages_latest.typescript-language-server;
  typescript = pkgs.nodePackages_latest.typescript;
in
{ imports = [ ./plugins.nix ];

  programs.neovim = {
    enable        = true;
    withNodeJs    = true;
    withPython3   = true;
    package       = pkgs.neovim-unwrapped;
    defaultEditor = true;

    viAlias      = true;
    vimAlias     = true;
    vimdiffAlias = true;

    extraConfig    = builtins.readFile ./rc.vim;
    extraLuaConfig =
      ''
      _G.typescript = {
        tsserverPath = "${tsserver}/bin/typescript-language-server",
        tslib        = "${typescript}/lib/node_modules/typescript/lib",
      }

      ${builtins.readFile ./init.lua}
      '';

    extraPackages = with pkgs;
      [ pkgs-unstable.rust-analyzer-unwrapped
        gopls
        python310Packages.jedi-language-server
        python310Packages.pylint
        lua-language-server
        python310Packages.autopep8
        shellcheck
        nil
        silicon

        tsserver
        typescript
      ];
  };

  xdg.configFile = {
    "nvim/lua".source      = ./lua;
    "nvim/ftplugin".source = ./ftplugin;
  };
}
