{ config, pkgs, inputs, ... }:

{
  home.username = "meowkita";
  home.homeDirectory = "/home/meowkita";
  home.stateVersion = "25.11";
  
  home.file.".config/niri/config.kdl".source = ./configs/niri/config.kdl;
  home.file.".config/alacritty/alacritty.toml".source = ./configs/alacritty/alacritty.toml;

  home.packages = with pkgs; [
    fuzzel
    obsidian
    vscodium
    fastfetch
    alacritty
    telegram-desktop

    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
