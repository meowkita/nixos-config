{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.limine.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "anomaly";
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;

  time.timeZone = "Asia/Almaty";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.meowkita = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  environment.systemPackages = with pkgs; [
    git
    tree
    wget
    neovim
  ];

  system.stateVersion = "25.11";
}
