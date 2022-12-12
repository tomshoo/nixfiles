{ nur, pkgs }: rec {
  basic = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    nix-index
    ntfs3g
    gnome.gnome-tweaks
    gnome.gnome-software
    cloudflare-warp
    gnomeExtensions.appindicator
  ];

  nix-ur = with nur.repos; [
    rewine.ttf-ms-win10
  ];

  packages = basic ++ nix-ur;
}
