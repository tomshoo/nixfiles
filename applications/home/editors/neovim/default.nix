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
    package = pkgs.neovim-unwrapped;
    withNodeJs = true;
    withPython3 = true;
    enable = true;

    plugins = with pkgs.vimPlugins; [
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
      trouble-nvim
      toggleterm-nvim
      nvim-web-devicons
      barbar-nvim
      nvim-tree-lua
      alpha-nvim
      rust-tools-nvim
      symbols-outline-nvim
      lualine-nvim
      nvim-lightbulb
      nvim-surround
      nvim-neoclip-lua
      lsp_signature-nvim
      null-ls-nvim
      onedark-nvim
      scrollbar-nvim
      neogit
      nvim-lspconfig
      indent-blankline-nvim

      telescope-nvim
      plenary-nvim
      telescope-ui-select-nvim
      telescope-frecency-nvim

      nvim-cmp
      nvim-snippy
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-nvim-lua
      cmp-snippy
      lspkind-nvim
      crates-nvim

      (nvim-treesitter.withPlugins (plugins:
        with plugins;
        [ c lua rust python json jsonc cpp markdown vim rasi comment bash toml nix ]
        ))
      nvim-treesitter-context
      nvim-treesitter-textobjects
      nvim-ts-rainbow
      playground
    ];

    extraPackages = with pkgs; [
      # Language servers
      nil
      sumneko-lua-language-server
      rust-analyzer

      # Null-ls
      shellcheck
      nixfmt

      #Utils
      ripgrep
    ];
    extraConfig = "echo 1";
  };


  # xdg.configFile."nvim".source = ./config;
  xdg.configFile = {
    "nvim/init.lua".source = ./init.lua;
    "nvim/lua".source      = ./lua;
    "nvim/after".source    = ./after;
    "nvim/ftplugin".source = ./ftplugin;
    "nvim/snippets".source = ./snippets;
  };
}
