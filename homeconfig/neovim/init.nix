{ pkgs, lib, ... }:
let
  loadPlugin = repo:
    { ref ? "master", ... }:
    pkgs.vimUtils.buildVimPluginFrom2Nix {
      pname = "${lib.strings.sanitizeDerivationName repo}";
      version = ref;
      src = builtins.fetchGit {
        url = "https://github.com/${repo}.git";
        ref = ref;
      };
    };
in {
  programs.neovim = {
    enable = true;

    extraPackages = with pkgs; [
      python310Packages.pynvim

      # Language servers
      rnix-lsp
      sumneko-lua-language-server
      rust-analyzer

      # Null-ls
      shellcheck
      nixfmt

      # Treesitter parsers
      (vimPlugins.nvim-treesitter.withPlugins (plugins:
        with plugins; [
          c
          lua
          rust
          python
          json
          jsonc
          cpp
          markdown
          vim
          rasi
          comment
          bash
          toml
          nix
        ]))
    ];
  };

  xdg.configFile."nvim".source = ./config;

}
