{ lib, ... }:
{
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "lunarclient"
      "vscode"
      "zoom"
      "rar"
      "steam"
      "steam-run"
      "steam-unwrapped"
      "steam-original"
    ];
}
