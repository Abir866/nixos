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
      "typst"
      "harper"
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
      autosave.after_delay.milliseconds = 1000;

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
        Typst = {
          language_servers = [
            "tinymist"
            "harper-ls"
            
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
        harper-ls = {
            settings = {
                    dialect = "British";
                    linters = {
                        # Disable specific rules
                        # For rule names consult tooltips and https://writewithharper.com/docs/rules
                        RuleName = false;
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
