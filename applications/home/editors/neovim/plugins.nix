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
in [ # Plugins that are not in the standard nix repository
  (mkPlugin "yioneko/nvim-yati" { })
  (mkPlugin "samjwill/nvim-unception" { })
  (mkPlugin "Darazaki/indent-o-matic" { ref = "master"; })
  (mkPlugin "petertriho/nvim-scrollbar" { })
  (mkPlugin "aserowy/tmux.nvim" { })
  (mkPlugin "kevinhwang91/nvim-ufo" { })
  (mkPlugin "kevinhwang91/promise-async" { })
  (mkPlugin "rmagatti/session-lens" { })
  (mkPlugin "lukas-reineke/virt-column.nvim" { ref = "master"; })
] ++ (with pkgs.vimPlugins; [
  # Misc
  vim-misc
  impatient-nvim
  FixCursorHold-nvim
  alpha-nvim
  nvim-neoclip-lua

  # FS based
  auto-session
  project-nvim
  mkdir-nvim
  toggleterm-nvim
  nvim-tree-lua
  undotree

  # Git stuff
  neogit
  gitsigns-nvim

  # Buffer management
  bufdelete-nvim
  bclose-vim

  # Some usefull stuff
  colorizer
  nvim-hlslens
  tabular

  # Look and feel
  onedark-nvim
  indent-blankline-nvim

  # Over the top HUD
  nvim-web-devicons
  barbar-nvim
  lualine-nvim

  # Yes keys
  which-key-nvim
  comment-nvim
  nvim-autopairs
  nvim-surround

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
  cmp-cmdline
  lspkind-nvim
  crates-nvim

  # Treesitter plugins
  nvim-treesitter.withAllGrammars
  nvim-treesitter-context
  nvim-treesitter-textobjects
  nvim-ts-rainbow
  playground
])
