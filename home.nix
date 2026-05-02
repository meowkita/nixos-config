{ config, pkgs, inputs, ... }:

{
  home.stateVersion = "25.11";
  home.username = "meowkita";
  home.homeDirectory = "/home/meowkita";
  
  home.file.".config/niri/config.kdl".source = ./configs/niri/config.kdl;
  home.file.".config/fuzzel/fuzzel.ini".source = ./configs/fuzzel/fuzzel.ini;
  home.file.".config/alacritty/alacritty.toml".source = ./configs/alacritty/alacritty.toml;

  home.packages = with pkgs; [
    bibata-cursors
    papirus-icon-theme

    mako
    waybar
    fuzzel
    obsidian
    vscodium
    fastfetch
    alacritty
    telegram-desktop

    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}
