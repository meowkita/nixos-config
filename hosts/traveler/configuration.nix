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
    kernelParams = [
      "nmi_watchdog=0"
      "nvme.noacpi=1"
    ];
    kernel.sysctl = {
      "vm.dirty_writeback_centisecs" = 1500;
    };
  };

  hardware = {
    graphics.enable = true;
    graphics.enable32Bit = true;
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
  };

  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
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
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    tlp = {
      enable = true;
      settings = {
          CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
          CPU_SCALING_GOVERNOR_ON_AC = "schedutil";

          CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
          CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";

          PLATFORM_PROFILE_ON_BAT = "low-power";
          PLATFORM_PROFILE_ON_AC = "balanced";

          RUNTIME_PM_ON_BAT = "auto";
          USB_AUTOSUSPEND = 1;
          WIFI_PWR_ON_BAT = "on";
          SOUND_POWER_SAVE_ON_BAT = 1;

          NMI_WATCHDOG = 0;
      };
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
      acpi
      tree
      wget
      btop
      neovim
      upower
      killall
      powertop
      pciutils
      lm_sensors
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
    extraGroups = [ "wheel" "networkmanager" "dialout" "lp" ];
  };

  programs = {
    niri.enable = true;
    xwayland.enable = true;
  };

  system.stateVersion = "25.11";
}
