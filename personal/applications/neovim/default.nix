{ pkgs, lib, ... }: {
  imports = [ ./plugins.nix ];

  programs.neovim = {
    enable = true;
    withNodeJs = true;
    package = pkgs.neovim-unwrapped;
    defaultEditor = true;

    extraPackages = with pkgs;
      [ rust-analyzer
        gopls
        python310Packages.jedi-language-server
        lua-language-server
        python310Packages.autopep8
        shellcheck
        nil
        silicon
      ];
  };

  xdg.configFile = {
    "nvim/init.lua".text = ''
    _G.typescript = {
      tsserverPath = "${pkgs.nodePackages_latest.typescript-language-server}/bin/typescript-language-server",
      tstLib       = "${pkgs.nodePackages_latest.typescript}/lib/node_modules/typescript/lib",
    }

    ${builtins.readFile ./init.lua}
    '';

    "nvim/rc.vim".source   = ./rc.vim;
    "nvim/lua".source      = ./lua;
    "nvim/ftplugin".source = ./ftplugin;
  };
}
