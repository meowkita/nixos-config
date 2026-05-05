{ config, pkgs, inputs, ... }:

{
  home.stateVersion = "25.11";
  home.username = "meowkita";
  home.homeDirectory = "/home/meowkita";

  home.file = {
    ".config/niri/config.kdl".source = ../../configs/niri/config.kdl;
    ".config/swaylock/config".source = ../../configs/swaylock/config;
    ".config/fuzzel/fuzzel.ini".source = ../../configs/fuzzel/fuzzel.ini;
    ".config/waybar/style.css".source = ../../configs/waybar/style.css;
    ".config/waybar/config.jsonc".source = ../../configs/waybar/config.jsonc;
    ".config/swaybg/wallpaper.png".source = ../../configs/swaybg/wallpaper.png;
    ".config/VSCodium/product.json".source = ../../configs/vscode/product.json;
    ".config/VSCodium/User/settings.json".source = ../../configs/vscode/settings.json;
    ".config/alacritty/alacritty.toml".source = ../../configs/alacritty/alacritty.toml;
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
    easyeffects
    wl-clipboard
    networkmanagerapplet

    # apps
    lutris
    blender
    vesktop
    spotify
    obsidian
    vscodium
    obs-studio
    prismlauncher
    telegram-desktop
    bitwarden-desktop
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default

    # overrides / hidden entries
    (lsp-plugins.overrideAttrs (oldAttrs: {
      postInstall = ''
        rm -rf $out/share/applications
      '';
    }))
  ];

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
