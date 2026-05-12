{ config, pkgs, inputs, ... }:

{
  home.stateVersion = "25.11";
  home.username = "meowkita";
  home.homeDirectory = "/home/meowkita";
  
  home.file = {
    ".config/mako/config".source = ../../configs/mako/config;
    ".config/swaybg/nms.jpg".source = ../../configs/swaybg/nms.jpg;
    ".config/niri/config.kdl".source = ../../configs/niri/config.kdl;
    ".config/swaylock/config".source = ../../configs/swaylock/config;
    ".config/fuzzel/fuzzel.ini".source = ../../configs/fuzzel/fuzzel.ini;
    ".config/fuzzel/powermenu.sh".source = ../../configs/fuzzel/powermenu.sh;
    ".config/waybar/style.css".source = ../../configs/waybar/style.css;
    ".config/waybar/config.jsonc".source = ../../configs/waybar/config.jsonc;
    ".config/VSCodium/product.json".source = ../../configs/vscode/product.json;
    ".config/VSCodium/User/settings.json".source = ../../configs/vscode/settings.json;
    ".config/alacritty/alacritty.toml".source = ../../configs/alacritty/alacritty.toml;
    ".config/btop/themes/nms.theme".source = ../../configs/btop/themes/nms.theme;
    ".config/btop/btop.conf".source = ../../configs/btop/btop.conf;
  };

  home.packages = with pkgs; [
    # theming
    bibata-cursors
    papirus-icon-theme

    # core desktop
    mako
    swaybg
    waybar
    fuzzel
    swayidle
    nautilus
    alacritty
    swaylock-effects

    # system utilities
    blueman
    cliphist
    fastfetch
    pavucontrol
    wl-clipboard
    networkmanagerapplet
    power-profiles-daemon

    # development
    go
    gcc
    rustup

    # apps
    zip
    unrar
    unzip
    p7zip
    spotify
    obsidian
    vscodium
    file-roller
    gnome-keyring
    android-studio
    telegram-desktop
    bitwarden-desktop
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  programs = {
    bash = {
      enable = true;
    };

    git = {
      enable = true;
      settings.user = {
        name = "meowkita";
        email = "meowkita@proton.me";
      };
    };

    starship = {
      enable = true;
      enableBashIntegration = true;

      settings = {
        add_newline = false;
        format = "$username$hostname$directory$git_branch$git_status$nix_shell$character";

        username = {
          show_always = true;
          style_user = "bold #78e7e8";
          format = "[$user]($style)";
        };

        hostname = {
          ssh_only = false;
          style = "bold #78e7e8";
          format = "[@$hostname]($style) ";
        };

        directory = {
          style = "bold #fff4d6";
          truncation_length = 3;
          truncate_to_repo = true;
          format = "[$path]($style) ";
        };

        git_branch = {
          symbol = " ";
          style = "#ff7a8a";
          format = "[$symbol$branch]($style) ";
        };

        git_status = {
          style = "#ffd166";
          format = "[$all_status$ahead_behind]($style) ";
        };

        nix_shell = {
          symbol = " ";
          style = "#78e7e8";
          format = "[$symbol$state]($style) ";
        };

        character = {
          success_symbol = "[❯](bold #a6e3a1)";
          error_symbol = "[❯](bold #ff7a8a)";
        };
      };
    };
  };

  home.pointerCursor = {
    size = 24;
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;

    gtk.enable = true;
    x11.enable = true;
  };

  gtk = {
    enable = true;

    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    cursorTheme = {
      size = 24;
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
    };
  };

  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}
