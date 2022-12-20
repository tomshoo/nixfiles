{ pkgs, ... }:
with pkgs; [
  vim
  wget
  nix-index
  ntfs3g # Windows NTFS Driver
  cloudflare-warp
  lm_sensors
]
