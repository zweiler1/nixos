{ pkgs }:
{
  packages = with pkgs; [
    kate
    polkit-kde-agent-1

    # Dolphin
    dolphin
    breeze
    breeze-icons

    # KDE Framework Packages for Dolphin and Icon Support
    qtstyleplugin-kvantum # For the KvAdaptaDark theme
    qtwayland
    kiconthemes
    kitemmodels
    kdeclarative
    kio
    kservice
    kirigami
    frameworkintegration
  ];
}
