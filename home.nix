{
  # config,
  lib,
  pkgs,
  userConfig,
  ...
}:
let
  flakePath = userConfig.nixos;
in
{
  imports = [
    ./sys/home.nix
  ];

  home = {
    shellAliases = {
      # shell conveniences
      x = "exit";
      clr = "clear";
      cls = "clear";
      cat = "bat -pp";
      icat = "kitten icat";
      cssh = "kitten ssh";
      ls = "eza -1 --icons=never";
      ll = "eza -1l";
      lessr = "less -R";
      tree = "eza --tree";
      py = "ptpython";
      cd-os = "cd ${flakePath}";

      # editing related
      e = "hx";
      eos = "e ${flakePath}";

      # reloading configs
      re-nix = "nh os switch";
      re-hm = "nh home switch";
      re-hm-fast = "home-manager switch --flake ${flakePath}";

      # package management
      yin = "nix-shell -p";
      yang = "nh search";
      wuji = "sudo -H nix-collect-garbage -d && nix-collect-garbage -d";
      yup = "nix flake update --flake ${flakePath} && re-nix && re-hm";

      # misc
      lg = lib.getExe pkgs.lazygit;
    };

    packages = with pkgs; [
      brave
      zoom-us
      wordpress
      libreoffice
      python313Packages.ptpython
      undetected-chromedriver
      chromedriver
      woeusb
      kooha
    ];
  };

  programs = {
    bottom = {
      enable = true;
      settings.styles.theme = "nord";
    };

    fzf = {
      enable = true;
      defaultOptions = [
        "--height 40%"
        "--border rounded"
        "--layout reverse"
      ];
      changeDirWidgetCommand = "zoxide query --list --score";
      changeDirWidgetOptions = [
        "--nth 2.. --accept-nth 2.. --scheme=path --exact --tiebreak='pathname,index'"
      ];
    };
  };
}
