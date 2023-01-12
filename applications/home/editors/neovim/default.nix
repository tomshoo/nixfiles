{ pkgs, lib, ... }: {
  imports = [ ./plugins.nix ];

  programs.neovim = {
    package = pkgs.neovim-unwrapped;
    withNodeJs = true;
    withPython3 = true;
    enable = true;

    extraPackages = with pkgs;
      [
        # Language servers
        nil
        sumneko-lua-language-server
        rust-analyzer
        gopls
        haskell-language-server
        python310Packages.jedi-language-server

        # Null-ls
        shellcheck
        nixfmt
        python310Packages.autopep8

        #Utils
        ripgrep
        fd
        silicon
      ] ++ (with nodePackages_latest; [
        # Node based language servers
        vim-language-server
        vscode-langservers-extracted
        bash-language-server

        # Null ls
        prettier
        eslint
        eslint_d

        # Extra dependencies
        typescript
      ]);
  };

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
