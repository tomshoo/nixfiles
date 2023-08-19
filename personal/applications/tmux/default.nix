{ pkgs, ... }: let
  tmux-session-manager = pkgs.writeShellScriptBin
    "tsman"
    (builtins.readFile ./tmux-session-manager.sh);
in {
  programs.tmux = {
    enable        = true;
    baseIndex     = 1;
    keyMode       = "vi";
    prefix        = "C-Space";
    sensibleOnTop = true;
    terminal      = "screen-256color";
    escapeTime    = 0;

    plugins = with pkgs.tmuxPlugins;
      [{ plugin      = vim-tmux-navigator;
         extraConfig = builtins.readFile ./tmux.vim-tmux-navigator.conf;
      }];

    extraConfig =
    ''
    ${builtins.readFile ./tmux.default.conf}
    bind 'C-r' split-window -v ${tmux-session-manager}/bin/tsman -i
    '';

  };

  home.packages = [ tmux-session-manager ];
}
