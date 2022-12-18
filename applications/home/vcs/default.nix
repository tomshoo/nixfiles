{ ... }: {
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
      url = { "https://github.com/" = { insteadOf = [ "gh:" "github:" ]; }; };
    };
  };
}
