{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nixpkgs.config.allowUnfree = true;

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
    bluetooth.enable = true;
    nvidia.modesetting.enable = true;
    nvidia.open = true;
  };

  networking = {
    hostName = "desktop";
    networkmanager.enable = true;
    firewall.enable = false;
  };

  time.timeZone = "Asia/Almaty";
  i18n.defaultLocale = "en_US.UTF-8";

  services = {
    xserver.enable = true;
    xserver.videoDrivers = [ "nvidia" ];
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
  };

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
    steam.enable = true;
    gamemode.enable = true;
    xwayland.enable = true;
  };

  system.stateVersion = "25.11";
}
