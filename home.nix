{ config, pkgs, ... }:

{
  home.username = "meowkita";
  home.homeDirectory = "/home/meowkita";
  home.stateVersion = "25.11";
  
  home.file.".config/niri/config.kdl".source = ./niri/config.kdl;
}
