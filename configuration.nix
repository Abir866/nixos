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

  #  environment.gnome.excludePackages = with pkgs; [
  #    nautilus
  #  ];

  #  programs = {
  #    thunar.enable = true;
  #    xfconf.enable = fals;
  #  };

    services = {
      xserver.displayManager.lightdm.enable = true;
      xserver.desktopManager.pantheon.enable = true;
    };
}
