{ pkgs, lib, ... }:
let plugins = import ./plugins.nix { inherit pkgs lib; };
in {
  programs.neovim = {
    package = pkgs.neovim-unwrapped;
    withNodeJs = true;
    withPython3 = true;
    enable = true;

    inherit plugins;

    extraPackages = with pkgs;
      [
        # Language servers
        nil
        sumneko-lua-language-server
        rust-analyzer
        python310Packages.jedi-language-server

        # Null-ls
        shellcheck
        nixfmt
        python310Packages.autopep8

        #Utils
        ripgrep
        fd
      ] ++ (with nodePackages_latest; [
        # Node based language servers
        vim-language-server
        vscode-langservers-extracted
        bash-language-server

        # Null ls
        prettier

        # Extra dependencies
        typescript
      ]);
  };

  # xdg.configFile."nvim".source = ./config;
  xdg.configFile = {
    "nvim/init.lua".text = ''
      _G.typescript = {
        tsserverPath  = "${pkgs.nodePackages_latest.typescript-language-server}/bin/typescript-language-server",
        typescriptLib = "${pkgs.nodePackages_latest.typescript}/lib/node_modules/typescript/lib",
      }
      ${builtins.readFile ./init.lua}
    '';
    "nvim/vimrc.vim".source = ./vimrc.vim;
    "nvim/lua".source = ./lua;
    #"nvim/after".source    = ./after;
    "nvim/ftplugin".source = ./ftplugin;
    "nvim/snippets".source = ./snippets;
  };
}
