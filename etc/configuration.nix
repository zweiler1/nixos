# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  # Import the unstable channel
  unstable = import <nixos-unstable> { };

  # Override hyprland in pkgs with unstable version
  #pkgsH = pkgs // {
  #hyprland = unstable.hyprland;
  #  hyprcursor = unstable.hyprcursor;
  #  hyprpicker = unstable.hyprpicker;
  #  hyprlock = unstable.hyprlock;
  #  hyprpaper = unstable.hyprpaper;
  #};

  # Packages on unstable base
  unstablePackages = (import ./packages/unstable.nix { pkgs = unstable; }).packages;
  hyprlandPackages = (import ./packages/hyprland.nix { pkgs = unstable; }).packages;
  # Packages on stable base
  systemPackages = (import ./packages/pkgs.nix { pkgs = pkgs; }).packages;
  kdePackages = (import ./packages/kdePackages.nix { pkgs = pkgs.kdePackages; }).packages;

  #hyprlandPkg = builtins.elemAt (builtins.filter (pkg: pkg.pname == "hyprland") hyprlandPackages) 0;
in
{
  system.stateVersion = "nixos-24.05";

  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./shell-commands.nix
    # Groupings to make the configuration.nix file smaller
    ./groups/hardware.nix
    ./groups/services.nix
    ./groups/programs.nix
  ];

  # Enable Hyprland
  #programs.hyprland = {
  #  enable = true;
  #package = hyprlandPkg;
  #};

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.zweiler1 = {
    isNormalUser = true;
    description = "Marc Zweiler";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ ];
  };

  boot = {
    # The Kernel
    kernelPackages = pkgs.linuxPackages_latest;
    # Enable Plymouth
    plymouth.enable = true;
    # Silent boot
    initrd.verbose = false;
    consoleLogLevel = 0;
    # Kernel parameters
    kernelParams = [ "quiet" "splash" ];
    # Bootloader
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  # Load SDDM after plymouth has finished
  systemd.services.display-manager.wants = [ "systemd-user-sessions.service" "multi-user.target" "network-online.target" ];
  systemd.services.display-manager.after = [ "systemd-user-sessions.service" "multi-user.target" "network-online.target" ];

  # Enable networking
  networking.networkmanager.enable = true;
  networking.hostName = "nixos"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "Europe/Vienna";

  # Select internationalisation properties.
  i18n.defaultLocale = "de_AT.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_AT.UTF-8";
    LC_IDENTIFICATION = "de_AT.UTF-8";
    LC_MEASUREMENT = "de_AT.UTF-8";
    LC_MONETARY = "de_AT.UTF-8";
    LC_NAME = "de_AT.UTF-8";
    LC_NUMERIC = "de_AT.UTF-8";
    LC_PAPER = "de_AT.UTF-8";
    LC_TELEPHONE = "de_AT.UTF-8";
    LC_TIME = "de_AT.UTF-8";
  };

  # Enable low latency audio
  security.rtkit.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable QT
  qt.enable = true;

  # Set environment variables
  environment.variables = rec {
    DOTNET_ROOT = "${pkgs.dotnet-sdk_7}";
    GTK_THEME = "Adwaita:dark";
    QT_QPA_PLATFORM = "wayland";
    QT_QPA_PLATFORMTHEME = "qt6ct";
    #XDG_CURRENT_DESKTOP = "KDE";
    #XDG_SESSION_DESKTOP = "KDE";
    XDG_SESSION_TYPE = "wayland";
    ICON_THEME = "breeze";
    QT_SCALE_FACTOR = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1"; # Automatic screen scaling for QT
    QT_SCREEN_SCALE_FACTORS = "1";
    QT_ENABLE_HIGHDPI_SCALING = "1"; # Enables High DPI Scaling for QT
    SCREEN_STATE = "on";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages =
    systemPackages ++
    kdePackages ++
    unstablePackages ++
    hyprlandPackages;

  # Font configuration
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    noto-fonts-extra
    dejavu_fonts
    font-awesome
    corefonts
    vistafonts
    # SDDM
    nerdfonts
  ];

  # List services that you want to enable:

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
