{ config, pkgs, inputs, ... }:

{
  home.stateVersion = "25.11";
  home.username = "meowkita";
  home.homeDirectory = "/home/meowkita";

  home.packages = with pkgs; [];

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
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}
