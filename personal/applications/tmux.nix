{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    keyMode = "vi";
    prefix = "C-Space";
    sensibleOnTop = true;
    terminal = "screen-256color";
    plugins = with pkgs.tmuxPlugins;
      [{ plugin = vim-tmux-navigator;
          extraConfig =
            ''
            is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"

            bind -n 'C-M-h' if-shell "$is_vim" 'send-keys M-h' 'resize-pane -L 1'
            bind -n 'C-M-j' if-shell "$is_vim" 'send-keys M-j' 'resize-pane -D 1'
            bind -n 'C-M-k' if-shell "$is_vim" 'send-keys M-k' 'resize-pane -U 1'
            bind -n 'C-M-l' if-shell "$is_vim" 'send-keys M-l' 'resize-pane -R 1'

            bind-key -T copy-mode-vi C-M-h resize-pane -L 1
            bind-key -T copy-mode-vi C-M-j resize-pane -D 1
            bind-key -T copy-mode-vi C-M-k resize-pane -U 1
            bind-key -T copy-mode-vi C-M-l resize-pane -R 1
            '';
      }];

    extraConfig =
      ''
      bind P paste-buffer

      bind-key -n Home send Escape "OH"
      bind-key -n End send Escape "OF"

      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi y send-keys -X copy-selection
      bind-key -T copy-mode-vi r send-keys -X rectangle-toggle

      ## Sane splitting
      bind '%' split-window -h -c "#{pane_current_path}"
      bind '"' split-window -v -c "#{pane_current_path}"

      ## Setup the panel
      set -g status-position top
      set -g status-bg       black
      set -g status-fg       white

      set -g status-left-length  50
      set -g status-right-length 30

      set -g status-left  '#S[#{pane_index}] + '
      set -g status-right '#T'

      ## Hopefully titles
      set -g set-titles        on
      set -g set-titles-string "#{pane_title}"

      ## Quiet everyone
      set -g visual-activity   off
      set -g visual-bell       off
      set -g visual-silence    off
      setw -g monitor-activity off
      set -g bell-action       none
      '';
  };
}
