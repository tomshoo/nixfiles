{ ... }: {
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      command_timeout = 2000;
    };
  };

  programs.bash = {
    enable = true;
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
      { FPATH = "$HOME/.config/bash/functions:$HOME/.bash/functions"; ## .bash/functions are for non persistant functions,
                                                                      ## basically for testing new autoload functions.
      };

    bashrcExtra =
      ''
      ${builtins.readFile ./bash/autoload.sh}
      '';

    initExtra =
      ''
      ${builtins.readFile ./common.sh}
      autoload $(IFS=:; echo $FPATH)
      alias reload-fpath='autoload $(IFS:; echo $FPATH)'

      bind '"\e[A": history-search-backward'
      bind '"\e[B": history-search-forward'
      '';
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;

    dotDir = ".config/zsh";

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "command-not-found" "sudo" ];
      theme = "clean";
    };

    initExtra =
      ''
      ${builtins.readFile ./common.sh}
      # Load custom functions
      autoload -Uz ~/.config/zsh/functions/*
      '';
  };

  xdg.configFile = {
    "zsh/functions".source = ./zsh/functions;
  };

  xdg.configFile = {
    "bash/functions".source = ./bash/functions;
  };
}
