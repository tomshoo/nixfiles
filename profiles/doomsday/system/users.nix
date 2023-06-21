{ pkgs,
  username,
  description,
  ...
} :
{ users.users."${username}" = {
    inherit description;

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

    packages = with pkgs;
      [ firefox
        git
      ];
  };
}
