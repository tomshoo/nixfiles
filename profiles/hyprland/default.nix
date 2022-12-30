{ config, lib, pkgs, ... }:
let packages = import ../../sysconfig/packages.nix { inherit pkgs; };
in {
  programs.hyprland.enable = true;
  services.dbus.enable = true;

  environment.variables = {
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
  };

  environment.loginShellInit = ''
    if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
      exec dbus-run-session Hyprland
    fi
  '';

  environment.systemPackages = packages
    ++ (with pkgs; [ wbg swaylock foot slurp ]);
}
