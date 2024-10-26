# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./shell_commands.nix
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "nixos-24.05"; # Did you read the comment?

  # Update AMD CPU microcode for security
  hardware.cpu.amd.updateMicrocode = true;

  # The Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Silent boot
  boot.initrd.verbose = false;
  boot.consoleLogLevel = 0;

  # Kernel parameters
  boot.kernelParams = [ "quiet" ];

  # Plymouth
  #boot.plymouth.enable = true;
  #boot.plymouth.theme = "bgrt";

  # Reduce swappiness to prioritize physical memory over swap
  boot.kernel.sysctl."vm.swappiness" = 10;

  # Enable networking
  networking.hostName = "nixos"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables networking in Hyprland
  networking.networkmanager.enable = true; # Enables networking in Plasma

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  #networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

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

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "at";
    #xkbVariant = "";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable docker virtualization, without it docker will not be able to connect to its daemon
  virtualisation.docker.enable = true;

  # Enable supergfxctl daemon
  services.supergfxd.enable = true;
  services.asusd = {
    enable = true;
    enableUserService = true;
  };

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  #services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;
  programs.hyprland.enable = true;

  # Enable XONE Package
  hardware.xone.enable = true;

  # Enable DRI support for OpenGL, 24.05
  #hardware.opengl = {
  #enable = true;
  #driSupport = true;
  #driSupport32Bit = true;
  #extraPackages = with pkgs; [ amdvlk ];
  #extraPackages32 = with pkgs; [ amdvlk ];
  #};
  # For unstable
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    #extraPackages = with pkgs; [ amdvlk ];
    #extraPackages32 = with pkgs; [ amdvlk ];
  };
  # Enable the LACT package (AMD Gpu settings gui)
  #systemd.packages = with; pkgs [ lact ];
  #systemd.services.lactd.wantedBy = ["multi-user.target"];

  # Enable Polkit
  security.polkit.enable = true;

  # Fixes GTK theming
  programs.dconf.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.cnijfilter_4_00 ];
  hardware.sane.enable = true; #enables scanning support for the printer

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.zweiler1 = {
    isNormalUser = true;
    description = "Marc Zweiler";
    extraGroups = [ "networkmanager" "wheel" "docker" "scanner" "lp" "plugdev" ];
  };

  # Set the environment variables used inside the bashrc file
  environment.variables = {
    DEV_ENVIRONMENT = "";
    ENV_PATH = "/home/zweiler1/NC/env";
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  # Enable pinentry for gnupg
  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    #pinentryFlavor = "curses"; Appearantly has no effect any more "please remove it"
    enableSSHSupport = true;
  };

  # Enable qt6ct
  #programs.qt6ct.enable = true;

  # Enable binaries to be executable
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = [ ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # System and terminal packages
    wget
    pv
    git
    git-credential-oauth
    git-credential-manager
    gnupg
    pinentry-curses #Needed by gpg to sign commits
    bash-completion
    nix-bash-completions
    bash-language-server
    lxqt.lxqt-policykit
    btrfs-progs
    libva-utils
    shared-mime-info
    lxde.lxmenu-data
    supergfxctl
    asusctl
    mesa
    bats
    fastfetch
    cups
    #carps-cups # Community driver for Canon printers
    cups-bjnp # Cups backend for Canon printers
    #cnijfilter_4_00 # Driver for the specific printer that we have
    vsftpd # very secure ftp daemon
    cached-nix-shell # instant nix-shell startup times

    # NVIM Dependencies
    gcc # c/cpp compiler
    ripgrep
    gnumake
    unzip
    cargo

    # CLI Tools
    lf
    fzf
    vim
    neovim
    nano
    btrfs-assistant
    htop
    #thefuck
    #docker
    killall
    smartmontools
    #lshw # list hardware (lshw -c display to display gpus)
    #glxinfo
    pciutils # for lspci and stuff
    bc # cli calculation evaluator
    #usbutils # lsusb and stuff
    #ffmpeg

    # Hyprland
    brightnessctl # control brightnes via shortcuts
    playerctl # media control via command line inputs
    hyprpicker
    networkmanagerapplet # GUI for selecting WiFi in Hyprland
    wlogout
    grim # screenshots
    slurp # screenshots
    hyprland
    hyprcursor
    hyprpaper
    hyprlandPlugins.hyprexpo
    hyprlock
    wofi
    waybar
    cliphist # clipboard manager for text and images
    wl-clipboard # default wayland clipboard manager
    wl-clipboard-x11 # Wrapper to make nvim copy to clipboard work
    dunst
    #xwaylandvideobridge
    #xdg-desktop-portal
    #xdg-desktop-portal-gtk
    #xdg-desktop-portal-gnome
    xdg-desktop-portal-hyprland
    galculator
    cmake
    meson
    cpio

    # Applications
    kitty
    lact # amd gpu gui settings
    thunderbird
    #qownnotes
    firefox
    onlyoffice-bin
    nextcloud-client
    #simple-scan # Gnome scanner application to scan documents
    gnome-calendar
    qdirstat
    qbittorrent
    vlc
    #miraclecast # miracast screen mirroring technology
    filezilla # ftp with gui
    #activitywatch
    #aw-qt # Tray Icon for AW
    nwg-look # GTK3 settings app

    # Social Applications
    #zapzap
    whatsapp-for-linux
    webcord
    #teams-for-linux # Unofficial teams client

    # DEV Applications
    vscodium
    codeium
    direnv # A shell extension that manages your environment, needed by vscodium
    #mysql-workbench
    #zed-editor

    # Configuration Applications
    #ventoy
    pavucontrol
    qpwgraph

    # Gaming related
    heroic
    lutris
    mangohud
    gamescope
    prismlauncher
    #moonlight-qt
    #sunshine
    #dualsensectl
    wineWowPackages.stable
    winetricks
    protonup-qt
    #linuxKernel.packages.linux_6_11.xone

  ] ++ (with kdePackages; [
    konsole

    # Dolphin
    dolphin
    breeze
    breeze-icons
    qtwayland
    qtsvg
    kio-fuse #to mount remote filesystems via FUSE
    kio-extras #extra protocols support (sftp, fish and more)

    kate
    partitionmanager
    #qt6ct
    kgpg
    kwallet
    kmenuedit
    sddm-kcm
    xdg-desktop-portal-kde
    xwaylandvideobridge
  ]);

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
  ];

  # List services that you want to enable:

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

}
