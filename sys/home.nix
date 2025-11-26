{
  lib,
  pkgs,
  userConfig,
  ...
}:
let
  homeDir = userConfig.home;
  userName = userConfig.username;
  flakePath = userConfig.nixos;
in
{
  imports = [
    ./config.nix
    ./unfree.nix
    ../pkg/fish.nix
    ../pkg/helix.nix
    ../pkg/zed.nix
  ];

  services = {
    home-manager = {
      autoExpire = {
        enable = true;
        frequency = "weekly";
        timestamp = "-30 days";
        store = {
          cleanup = true;
          options = "--delete-older-than 30d";
        };
      };
    };
    gnome-keyring.enable = true;
  };
  nix.gc.dates = "weekly";

  home = {
    # Home Manager needs a bit of information about you and the paths it should
    # manage.
    username = userName;
    homeDirectory = lib.mkDefault (/. + homeDir);

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "24.11"; # Please read the comment before changing.

    # The home.packages option allows you to install Nix packages into your
    # environment.
    packages = with pkgs; [
      # # Adds the 'hello' command to your environment. It prints a friendly
      # # "Hello, world!" when run.
      # hello

      # # It is sometimes useful to fine-tune packages, for example, by applying
      # # overrides. You can do that directly here, just don't forget the
      # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
      # # fonts?
      # (nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

      # # You can also create simple shell scripts directly inside your
      # # configuration. For example, this adds a command 'my-hello' to your
      # # environment:
      # (writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')

      nerd-fonts.caskaydia-cove
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      xorg.xdpyinfo
      docker
      xclip
      unzip
    ];

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    file = {
      # # Building this configuration will create a copy of 'dotfiles/screenrc' in
      # # the Nix store. Activating the configuration will then make '~/.screenrc' a
      # # symlink to the Nix store copy.
      # ".screenrc".source = dotfiles/screenrc;

      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';
    };

    # Home Manager can also manage your environment variables through
    # 'home.sessionVariables'. These will be explicitly sourced when using a
    # shell provided by Home Manager. If you don't want to manage your shell
    # through Home Manager then you have to manually source 'hm-session-vars.sh'
    # located at either
    #
    #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  /etc/profiles/per-user/${userName}/etc/profile.d/hm-session-vars.sh
    #
    sessionVariables = {
      HOME_MANAGER_BACKUP_EXT = "hm.bak";
    };

    shell.enableShellIntegration = true;
  };

  xdg.configFile = {
    # Custom Kitty Icon
    # License: MIT Copyright: 2024, Andrew Haust <https://github.com/sodapopcan/kitty-icon>
    "kitty/kitty.app.png".source = ../cfg/kitty.app.png;
    "ptpython/config.py".source = ../cfg/ptpython.py;
    "lf" = {
      source = ../cfg/lf;
      recursive = true;
    };
  };

  programs = {
    nh = {
      enable = true;
      flake = flakePath;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    kitty = {
      enable = true;
      themeFile = "kanagawa_dragon";
      enableGitIntegration = true;
      font = {
        package = pkgs.nerd-fonts.caskaydia-cove;
        name = "CaskaydiaCove Nerd Font Mono";
        size = 14;
      };
      settings = {
        shell = lib.getExe pkgs.zsh + " -c " + lib.getExe pkgs.fish;
        tab_bar_edge = "top";
        enabled_layouts = "tall";
        enable_audio_bell = false;
        background_opacity = 0.96;
        update_check_interval = 0;
        hide_window_decorations = "yes";
      };
      keybindings = {
        "super+." = "layout_action bias 64";
        "super+[" = "previous_window";
        "super+]" = "next_window";
      };
    };

    lf = {
      enable = true;
      settings = {
        number = true;
        relativenumber = true;
        icons = true;
        sortby = "ext";
        cleaner = "~/.config/lf/cleaner";
        previewer = "~/.config/lf/previewer";
      };
      keybindings = {
        D = "delete";
        x = "cut";
      };
      commands.open = ''
        ''${{
          case $(file --mime-type -Lb $f) in
            application/pdf) ${lib.getExe pkgs.tdf} $fx;;
            *) for f in $fx; do $OPENER $f > /dev/null 2> /dev/null & done;;
          esac
        }}
      '';
    };

    zoxide = {
      enable = true;
      options = [
        "--cmd"
        "c"
      ];
    };

    bat = {
      enable = true;
      config.theme = "kanagawa-dragon";
      themes = {
        kanagawa-dragon.src = ../cfg/kanagawa-dragon.tmTheme;
      };
    };

    eza = {
      enable = true;
      colors = "auto";
      git = true;
      icons = "auto";
      extraOptions = [
        "--group-directories-last"
        "--sort=extension"
      ];
    };

    fd = {
      enable = true;
      ignores = [
        ".git/"
        "*.bak"
      ];
      extraOptions = [ "--color=always" ];
    };

    git = {
      enable = true;
      package = pkgs.gitFull;
      settings = {
        user = {
          name = "Abir866";
          email = "113381433+Abir866@users.noreply.github.com";
        };
        init.defaultBranch = "main";
        credential.helper = "store";
        pull.rebase = false;
        gpg.format = "ssh";
        user.signingKey = "~/.ssh/id_ed25519.pub";
        commit.gpgSign = true;
        merge.conflictStyle = "zdiff3";
      };
    };

    delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        dark = true;
        line-numbers = true;
        syntax-theme = "kanagawa-dragon";
        hyperlinks = true;
      };
    };

    lazygit = {
      enable = true;
      settings = {
        promptToReturnFromSubprocess = false;
        git = {
          paging = {
            pager = "${lib.getExe pkgs.delta} --paging=never --hyperlinks-file-link-format=\"lazygit-edit://{path}:{line}\"";
          };
        };
        gui = {
          theme = {
            activeBorderColor = [
              "#8ba4b0"
              "bold"
            ];
            inactiveBorderColor = [ "#a6a69c" ];
            optionsTextColor = [ "#8ba4b0" ];
            selectedLineBgColor = [ "#2d4f67" ];
            cherryPickedCommitBgColor = [ "#2d4f67" ];
            cherryPickedCommitFgColor = [ "#a292a3" ];
            unstagedChangesColor = [ "#c4746e" ];
            defaultFgColor = [ "#c5c9c5" ];
            searchingActiveBorderColor = [ "#c4b28a" ];
          };

          authorColors = {
            "*" = "#7fb4ca";
          };
        };
      };
    };

    ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks."*".extraOptions.addKeysToAgent = "yes";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
