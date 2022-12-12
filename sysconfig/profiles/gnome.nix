{ config, lib, pkgs, ... }@extra: {
  services.xserver = {
    enable = true;
    layout = "us";
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ALL = "en_IN";
      LC_NAME = "en_IN";
      LC_ADDRESS = "en_IN";
      LC_MEASUREMENT = "en_IN";
      LC_PAPER = "en_IN";
      LC_TIME = "en_IN";
      LC_IDENTIFICATION = "en_IN";
      LC_NUMERIC = "en_IN";
      LC_TELEPHONE = "en_IN";
    };
  };
}
