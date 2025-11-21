{ pkgs, userConfig, ... }:
let
  userName = userConfig.username;
in
{
  nix = {
    package = pkgs.nixVersions.stable;
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };
    settings = {
      trusted-users = [ userName ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      download-buffer-size = 524288000;
    };
  };
}
