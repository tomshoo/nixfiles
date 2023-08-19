{ config, ... }: {
  programs.bash =
    { enable               = true;
      enableVteIntegration = true;

      historyIgnore =
        [ "ls" "exa" "cd" "clear" "exit" "history" "file" "z" "zi" ];

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
      enableVteIntegration     = true;

      dotDir = ".config/zsh";
      autocd = true;

      history =
        { extended              = true;
          expireDuplicatesFirst = true;
          ignoreDups            = true;
          share                 = false;
        };

      shellAliases =
        { clear-history = "echo > ~/.zsh_history";
          grep          = "grep --color=auto";
          ls            = "exa";
        };

      completionInit =
        ''
        autoload -U compinit     && compinit
        autoload -U bashcompinit && bashcompinit
        '';

      initExtra               = builtins.readFile ./zsh/zshrc;
      initExtraBeforeCompInit = builtins.readFile ./zsh/zshrc_pre_compinit;
      initExtraFirst          =
        ''
        function __load_file() { [ -r "$1" ] && source "$1"; }
        [[ -n "$(command ls -A "$ZDOTDIR/functions")" ]] && autoload -Uz "$ZDOTDIR/functions/"*
        '';

      localVariables =
        { MANROFFOPT = "-c";
          MANPAGER   = "sh -c 'col -bx | bat -l man -p'";
        };
    };

  home.shellAliases =
    { edit = "${config.home.sessionVariables.EDITOR}";
      open = "xdg-open";
    };

  xdg.configFile =
    { "zsh/functions".source        = ./zsh/functions;
      "zsh/zsh_aliases".source      = ./zsh/zsh_aliases;
      "zsh/zsh_abbrevations".source = ./zsh/zsh_abbrevations;
      "zsh/zsh_prompt".source       = ./zsh/zsh_prompt;
      "zsh/zsh_vcs".source          = ./zsh/zsh_vcs;
    };

  xdg.configFile =
    { "bash/functions".source = ./bash/functions;
    };
}
