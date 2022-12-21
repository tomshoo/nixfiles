{ pkgs, lib, ... }:
let
  mkPlugin = repo:
    { ref ? "main", buildInputs ? [ ], ... }:
    pkgs.vimUtils.buildVimPluginFrom2Nix {
      pname = "${lib.strings.sanitizeDerivationName repo}";
      version = ref;
      src = builtins.fetchGit {
        url = "https://github.com/${repo}.git";
        inherit ref;
      };
      inherit buildInputs;
    };
in {
  programs.neovim = {
    package = pkgs.neovim-unwrapped;
    withNodeJs = true;
    withPython3 = true;
    enable = true;

    plugins = [
      (mkPlugin "yioneko/nvim-yati" { })
      (mkPlugin "samjwill/nvim-unception" { })
      (mkPlugin "Darazaki/indent-o-matic" { ref = "master"; })
      (mkPlugin "petertriho/nvim-scrollbar" { })
      (mkPlugin "aserowy/tmux.nvim" { })
      (mkPlugin "kevinhwang91/nvim-ufo" { })
      (mkPlugin "kevinhwang91/promise-async" { })
      (mkPlugin "rmagatti/session-lens" { })
    ] ++ (with pkgs.vimPlugins; [
      auto-session
      nvim-hlslens
      impatient-nvim
      mkdir-nvim
      colorizer
      bufdelete-nvim
      tabular
      vim-misc
      comment-nvim
      FixCursorHold-nvim
      bclose-vim
      gitsigns-nvim
      which-key-nvim
      project-nvim
      nvim-autopairs
      toggleterm-nvim
      nvim-web-devicons
      barbar-nvim
      nvim-tree-lua
      alpha-nvim
      lualine-nvim
      nvim-surround
      nvim-neoclip-lua
      onedark-nvim
      neogit
      indent-blankline-nvim

      # Lsp plugins
      nvim-lspconfig
      null-ls-nvim
      lsp_signature-nvim
      lsp-format-nvim
      nvim-lightbulb
      rust-tools-nvim
      symbols-outline-nvim
      trouble-nvim
      fidget-nvim

      # Configure telescope
      telescope-nvim
      plenary-nvim
      telescope-ui-select-nvim
      telescope-frecency-nvim

      # nvim-cmp completion engine
      nvim-cmp
      nvim-snippy
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-nvim-lua
      cmp-snippy
      lspkind-nvim
      crates-nvim

      nvim-treesitter.withAllGrammars
      nvim-treesitter-context
      nvim-treesitter-textobjects
      nvim-ts-rainbow
      playground
    ]);

    extraPackages = with pkgs; [
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
    ];
  };

  # xdg.configFile."nvim".source = ./config;
  xdg.configFile = {
    "nvim/init.lua".source = ./init.lua;
    "nvim/lua".source = ./lua;
    #"nvim/after".source    = ./after;
    "nvim/ftplugin".source = ./ftplugin;
    "nvim/snippets".source = ./snippets;
  };
}
