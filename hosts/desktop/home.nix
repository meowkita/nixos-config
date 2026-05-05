{ config, pkgs, inputs, ... }:

{
  home.stateVersion = "25.11";
  home.username = "meowkita";
  home.homeDirectory = "/home/meowkita";
  
  home.file = {
    ".config/niri/config.kdl".source = ../../configs/niri/config.kdl;
    ".config/swaylock/config".source = ../../configs/swaylock/config;
    ".config/fuzzel/fuzzel.ini".source = ../../configs/fuzzel/fuzzel.ini;
    ".config/swaybg/wallpaper.png".source = ../../configs/swaybg/wallpaper.png;
    ".config/VSCodium/product.json".source = ../../configs/vscode/product.json;
    ".config/VSCodium/User/settings.json".source = ../../configs/vscode/settings.json;
    ".config/alacritty/alacritty.toml".source = ../../configs/alacritty/alacritty.toml;
  };

  home.packages = with pkgs; [
    bibata-cursors
    papirus-icon-theme

    gvfs
    mako
    swaybg
    waybar
    fuzzel
    lutris
    blueman
    vesktop
    spotify
    nautilus
    cliphist
    obsidian
    vscodium
    swayidle
    fastfetch
    alacritty
    obs-studio
    pavucontrol
    easyeffects
    wl-clipboard
    prismlauncher
    gnome-keyring
    swaylock-effects
    telegram-desktop
    bitwarden-desktop
    networkmanagerapplet

    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default

    (pkgs.lsp-plugins.overrideAttrs (oldAttrs: {
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
