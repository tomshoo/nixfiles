{ ... }: {
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      ${builtins.readFile ./common.sh}
      ${builtins.readFile ./bash/extra.bash}
    '';

    shellAliases = {
      doom = "~/.emacs.d/bin/doom";
      nvim = "TERM=screen-256color nvim";
    };
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "command-not-found"
        "sudo"
        "zsh-interactive-cd"
        "python"
        "copyfile"
        "copybuffer"
        "web-search"
        "fastfile"
      ];
      theme = "clean";
    };

    shellAliases = {
      nvim = "TERM=screen-256color nvim";
      ls = "exa";
    };

    initExtra = ''
      ${builtins.readFile ./common.sh}
      ${builtins.readFile ./zsh/extra.zsh}
    '';
  };
}
