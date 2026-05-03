{ config, pkgs, inputs, ... }:

{
  home.stateVersion = "25.11";
  home.username = "meowkita";
  home.homeDirectory = "/home/meowkita";
  
  home.file.".config/niri/config.kdl".source = ../../configs/niri/config.kdl;
  home.file.".config/swaylock/config".source = ../../configs/swaylock/config;
  home.file.".config/fuzzel/fuzzel.ini".source = ../../configs/fuzzel/fuzzel.ini;
  home.file.".config/alacritty/alacritty.toml".source = ../../configs/alacritty/alacritty.toml;

  home.file.".config/VSCodium/product.json".source = ../../configs/vscode/product.json;
  home.file.".config/VSCodium/User/settings.json".source = ../../configs/vscode/settings.json;

  home.packages = with pkgs; [
    bibata-cursors
    papirus-icon-theme

    mako
    waybar
    fuzzel
    obsidian
    vscodium
    swayidle
    fastfetch
    alacritty
    swaylock-effects
    telegram-desktop

    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    extensions = with pkgs.vscode-extensions; [
      esbenp.prettier-vscode
      golang.go
      o4x.base16-tomorrow
      openai.chatgpt
      rust-lang.rust-analyzer
      tal7aouy.icons
      tamasfe.even-better-toml
      vscode-icons-team.vscode-icons
    ];
  };

  gtk = {
    enable = true;
    
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

  home.pointerCursor = {
    size = 24;
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;

    gtk.enable = true;
    x11.enable = true;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}
