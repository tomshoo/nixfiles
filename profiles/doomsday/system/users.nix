{ username,
  description,
  pkgs,
  ...
} :
{ users.users."${username}" = {
    inherit description;

    shell = pkgs.zsh;
    initialPassword = "${username}";
    isNormalUser = true;
    extraGroups =
      [ "networkmanager"
        "wheel"
        "audio"
        "video"
        "input"
        "power"
        "docker"
      ];

    packages = [];
  };

  environment.pathsToLink = [ "/share/zsh" ];
}
