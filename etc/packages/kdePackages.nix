{ pkgs }: {
  packages = with pkgs; [
    # KDE Packages
    qt6ct
    qtwayland
    kgpg # GPG Key manager for hyprland

    # KDE Connect
    kdeconnect-kde

    # Dolphin
    dolphin
    breeze
    breeze-icons

    # KDE Framework Packages for Dolphin and Icon Support
    kiconthemes
    kitemmodels
    kdeclarative
    kio
    kservice
    kirigami
    frameworkintegration

    # SDDM
    sddm
    qt5compat
  ];
}
