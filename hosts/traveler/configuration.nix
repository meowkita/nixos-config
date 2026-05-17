{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
    android_sdk.accept_license = true;
  };
  
  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    optimise.automatic = true;
    gc = {
      dates = "weekly";
      options = "--delete-older-than 14d";
      automatic = true;
    };
  };
  
  boot = {
    loader.limine.enable = true;
    loader.efi.canTouchEfiVariables = true;
    consoleLogLevel = 3;
  };

  hardware = {
    graphics.enable = true;
    graphics.enable32Bit = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };
  
  networking = {
    hostName = "traveler";
    networkmanager.enable = true;
    firewall.enable = false;
  };

  time.timeZone = "Asia/Almaty";
  i18n.defaultLocale = "en_US.UTF-8";

  services = {
    gvfs.enable = true;
    udisks2.enable = true;
    xserver.enable = true;
    gnome.gnome-keyring.enable = true;
    power-profiles-daemon.enable = true;
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];
  };

  security.polkit.enable = true;

  environment = {
    variables = {
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      OZONE_PLATFORM = "wayland";
    };

    systemPackages = with pkgs; [
      git
      tree
      wget
      btop
      neovim
      killall
      brightnessctl
      xwayland-satellite
    ];
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
  ];

  users.users.meowkita = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  programs = {
    niri.enable = true;
    xwayland.enable = true;
  };

  system.stateVersion = "25.11";
}
