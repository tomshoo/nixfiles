{ pkgs, ... }: {
  programs.gh = {
    enable = true;
    enableGitCredentialHelper = true;
  };

  programs.git = {
    enable = true;
    userName = "Shubhanshu Tomar";
    userEmail = "tomarshubhanshu@protonmail.ch";
    extraConfig = {
      init.defaultBranch = "master";
      url = {
        "https://github.com/" = { insteadOf = [ "gh:" "github:" ]; };
        "https://gitlab.com/" = { insteadOf = [ "gl:" "gitlab:" ]; };
      };
      credential."https://gitlab.com".helper =
        "${pkgs.glab}/bin/glab auth git-credential";
    };
  };
}
