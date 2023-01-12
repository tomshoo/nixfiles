{ pkgs, ... }@opts:
let username = opts.username;
in {
  home.packages = with pkgs; [ glab ];

  xdg.configFile."glab-cli/config.yml".text = ''
    git_protocol: ssh
    editor:
    browser:
    glamour_style: dark
    check_update: false
    display_hyperlinks: false
    hosts:
        ${builtins.readFile /home/${username}/.glab.hosts}
  '';

  programs.git.extraConfig.credential."https://gitlab.com".helper =
    "${pkgs.glab}/bin/glab auth git-credential";
}
