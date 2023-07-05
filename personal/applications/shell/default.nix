{ config, ... }: {
  programs.starship =
    { enable                = true;
      enableBashIntegration = true;
      enableZshIntegration  = true;
      enableFishIntegration = true;

      settings = {
        command_timeout = 2000;
        format          = "$all$hostname$status$character";
        hostname        =
          { ssh_only = false;
            format   = "[$hostname]($style) ";
          };
        directory.format       = "inside [$path]($style)[$read_only]($read_only_style) ";
        character.error_symbol = "[󰚌](bold red)";
        status =
          { disabled = false;
            format   = "[$status]($style) ";
          };
      };
    };

  programs.bash =
    { enable               = true;
      enableVteIntegration = true;

      historyIgnore =
        [ "ls"
          "exa"
          "cd"
          "clear"
          "exit"
          "history"
          "file"
          "z"
          "zi"
        ];

      sessionVariables =
        { FPATH = "$HOME/.config/bash/functions:$HOME/.bash/functions";
        };

      bashrcExtra =
        builtins.readFile ./bash/autoload.sh;

      initExtra =
        ''
        ${builtins.readFile ./common.sh}
        autoload $(IFS=:; echo $FPATH)
        alias reload-fpath='autoload $(IFS:; echo $FPATH)'

        bind '"\e[A": history-search-backward'
        bind '"\e[B": history-search-forward'
        '';
    };

  programs.zsh =
    { enable                   = true;
      enableAutosuggestions    = true;
      enableCompletion         = true;
      enableSyntaxHighlighting = true;

      dotDir = ".config/zsh";

      oh-my-zsh =
        { enable  = true;
          plugins = [ "git" "command-not-found" "sudo" ];
        };

      initExtra =
        ''
        ${builtins.readFile ./common.sh}
        # Load custom functions
        autoload -Uz ~/.config/zsh/functions/*
        '';
    };

  programs.fish =
    { enable = true;
      functions.fish_greeting = builtins.readFile ./fish/functions/fish_greeting.fish;
    };

  home.shellAliases =
    { edit = "${config.home.sessionVariables.EDITOR}";
      open = "xdg-open";
    };

  xdg.configFile =
    { "zsh/functions".source = ./zsh/functions;
    };

  xdg.configFile =
    { "bash/functions".source = ./bash/functions;
    };
}
