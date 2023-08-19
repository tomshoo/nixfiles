{ pkgs, lib, ... } : let
mkPlugin = repo: { ref ? "main", host ? "github.com" } : pkgs.vimUtils.buildVimPluginFrom2Nix
  { name = "${lib.strings.sanitizeDerivationName repo}";
    version = ref;
    src = builtins.fetchGit
      { url = "https://${host}/${repo}.git";
        inherit ref;
      };
  };
in {
  programs.neovim.plugins = (with pkgs.vimPlugins;
    [ FixCursorHold-nvim
      nvim-hlslens
      tabular
      bclose-vim
      vim-tmux-navigator
      wilder-nvim
      which-key-nvim
      nvim-tree-lua

      undotree
      neogit
      gitsigns-nvim

      nvim-web-devicons
      barbar-nvim
      lualine-nvim

      nvim-autopairs
      nvim-surround
      comment-nvim

      nvim-lspconfig
      null-ls-nvim
      lsp_signature-nvim
      rust-tools-nvim
      clangd_extensions-nvim
      neodev-nvim
      trouble-nvim
      fidget-nvim

      nvim-cmp
      nvim-snippy
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-snippy
      crates-nvim

      nvim-dap
      nvim-dap-ui

      nvim-treesitter.withAllGrammars
      nvim-treesitter-context
      nvim-treesitter-textobjects

      telescope-nvim
      plenary-nvim
      telescope-ui-select-nvim
      telescope-frecency-nvim

      sonokai
      direnv-vim

      (mkPlugin "cljoly/telescope-repo.nvim" { ref = "master"; })
    ]);
}
