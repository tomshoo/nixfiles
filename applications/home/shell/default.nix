{ ... }: {
  programs.bash = {
    enable = true;
    # bashrcExtra = ''
    #   nix-index-fetch() {
    #     filename="index-$(uname -m)-$(uname | tr A-Z a-z)"
    #     [ ! -d ~/.cache/nix-index ] && mkdir ~/.cache/nix-index
    #     pushd ~/.cache/nix-index/ || return 1
    #     wget -q -N https://github.com/Mic92/nix-index-database/releases/latest/download/$filename
    #     ln -f $filename files
    #     popd || return 1
    #   }
    # '';
    bashrcExtra = builtins.readFile ./bash/extra.bash;
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
      plugins =
        [ "git" "command-not-found" "sudo" "zsh-interactive-cd" "zoxide" ];
      theme = "clean";
    };

    shellAliases = { nvim = "TERM=screen-256color nvim"; };
    # initExtra = ''
    #   cd() {
    #     z "$@"
    #     if [[ -a shell.nix ]] && [ -z "$NIX_SHELL_ACTIVE" ]; then
    #       export NIX_SHELL_ACTIVE=1
    #       nix-shell
    #     fi
    #   }
    #
    # '';
    initExtra = builtins.readFile ./zsh/extra.zsh;
  };
}
