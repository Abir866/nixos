{
  programs.zed-editor = {
    enable = true;
    extensions = [
      "dockerfile"
      "git-firefly"
      "kanagawa-themes"
      "lua"
      "nix"
      "sql"
      "warp-one-dark"
      "zed-docker-compose"
    ];
    userSettings = {
      auto_update = false;
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      disable_ai = true;
      theme = {
        mode = "dark";
        dark = "Warp One Dark";
        light = "Kanagawa Lotus";
      };
      buffer_font_family = "CaskaydiaCove Nerd Font";
      buffer_font_size = 13;

      vim_mode = true;
      cursor_blink = false;
      vim = {
        toggle_relative_line_numbers = true;
      };
      terminal = {
        dock = "right";
        shell.program = "fish";
      };
      calls = {
        mute_on_join = true;
      };

      minimap = {
        show = "auto";
        thumb = "hover";
      };

      prettier = {
        tabWidth = 2;
        singleQuote = false;
      };

      languages = {
        Nix = {
          language_servers = [
            "nixd"
            "!nil"
          ];
        };
        JavaScript = {
          prettier = {
            tabWidth = 4;
          };
        };
      };

      lsp = {
        nixd = {
          settings = {
            formatting = {
              command = [ "nixfmt" ];
            };
            diagnostics = {
              ignored = [ "sema-extra-with" ];
            };
          };
        };
      };
    };
    userKeymaps = [
      {
        context = "Workspace";
        bindings = {
          "secondary-`" = "terminal_panel::Toggle";
          "secondary-b" = "workspace::ToggleRightDock";
          "secondary-alt-b" = "workspace::ToggleLeftDock";
        };
      }
    ];
  };
}
