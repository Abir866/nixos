{ pkgs, ... }:
{
  programs.helix = {
    enable = true;
    package = pkgs.evil-helix;
    defaultEditor = true;
    settings = {
      theme = "kanagawa-dragon";
      editor = {
        auto-format = true;
        line-number = "relative";
        lsp.display-messages = true;
        soft-wrap.enable = true;
        file-picker.hidden = false;
      };
      keys.normal = {
        ":" = "collapse_selection";
        ";" = "command_mode";
        "Meta-f" = ":format";
        "Meta-s" = ":write";
        "Meta-x" = ":write-quit";
        "Meta-z" = ":quit";
      };
    };
    languages = {
      language = [
        {
          name = "nix";
          language-servers = [ "nixd" ];
        }
        {
          name = "typescript";
          formatter = {
            command = "prettier";
            args = [
              "--parser"
              "typescript"
            ];
          };
        }
      ];
    };
  };
}
