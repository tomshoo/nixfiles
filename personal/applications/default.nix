{ pkgs-unstable, ... }: {
  imports =
    [ ./shell
      ./neovim
      ./tmux
    ];

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
    options = [ "--cmd cd" ];
  };

  programs.gh = {
    enable = true;
    enableGitCredentialHelper = true;
    settings.editor = "nvim";
  };

  programs.git = {
    enable = true;
    userName = "Shubhanshu Tomar";
    userEmail = "57960301+tomshoo@users.noreply.github.com";
    extraConfig = {
      credential."https://gitlab.com".helper = "${pkgs-unstable.glab}/bin/glab auth git-credential";
      url = {
        "https://github.com/".insteadOf = "gh:";
        "https://gitlab.com/".insteadOf = "gl:";
      };
    };
  };
}
