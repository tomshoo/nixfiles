{ username,
  description,
  ...
} :
{ users.users."${username}" = {
    inherit description;

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
}
