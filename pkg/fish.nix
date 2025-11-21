{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs = {
    fish = {
      enable = true;
      shellInit = ''
        fish_add_path ~/.local/bin
        fish_vi_key_bindings
      '';
      functions = {
        fish_greeting.body = "";
        src.body = "exec fish";
        fm.body = "cd \"$(${lib.getExe pkgs.lf} -print-last-dir \"$argv\")\"";
        fan.body = "du -hd1 \"$argv[1]\" | sort -hr";
        unly.body = "curl -Is \"$argv[1]\" | grep ^location | cut -d \" \" -f 2";
        etch.body = "sudo dd bs=4M if=$argv[2] of=/dev/r$argv[1] status=progress oflag=sync";
      };
      shellAbbrs = {
        ga = "git add";
        gc = "git commit";
        gaa = "git add --all";
        gca = "git commit --amend";
        gcf = "git commit --fixup";
        gcm = "git commit --message";
        grb = "git rebase --interactive";
        gcam = "git commit --amend --message";
        grbs = "git rebase --interactive --autosquash";
      };
    };
    starship.enable = config.programs.fish.enable;
  };
}
