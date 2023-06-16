{ pkgs, username, description, ... } : {
  users.users."${username}" = {
    inherit description;

    isNormalUser = true;
    extraGroups =
      [ "networkmanager"
        "wheel"
        "audio"
        "video"
        "input"
        "power"
      ];

    packages = with pkgs;
      [ firefox
        git
      ];
  };
}
