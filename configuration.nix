{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.limine.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "laptop";
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;

  time.timeZone = "Asia/Almaty";
  i18n.defaultLocale = "en_US.UTF-8";
  
  programs.niri.enable = true;
  programs.steam.enable = true;
  programs.xwayland.enable = true;
  programs.gamemode.enable = true;

  hardware.graphics.enable = true;

  services.xserver.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  users.users.meowkita = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    packages = with pkgs; [
      godot
      lutris
      spotify
      vesktop
      obsidian
      vscodium
      obs-studio
      libreoffice
      prismlauncher
      telegram-desktop
    ];
  };

  environment.systemPackages = with pkgs; [
    git
    wget
    btop
    neovim
    fuzzel
    alacritty
    fastfetch
    brightnessctl
    xwayland-satellite
  ];

  system.stateVersion = "25.11";
}
