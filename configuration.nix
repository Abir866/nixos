{
  # config,
  # lib,
  pkgs,
  ...
}:
{
  imports = [
    ./sys/configuration.nix
  ];
  environment.gnome.excludePackages = with pkgs; [
    nautilus
  ];
}
