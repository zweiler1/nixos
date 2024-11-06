{ pkgs ? import <nixos-unstable> { } }:
{
  packages = with pkgs; [
    #hyprland
    hyprcursor
    hyprpicker
    hyprlock
    hyprpaper

    xdg-desktop-portal-hyprland
    xdg-desktop-portal-kde
    xdg-desktop-portal
    wl-clipboard
    wl-clipboard-x11
    wofi
    pavucontrol # Audio management
    qpwgraph
    brightnessctl # control brightnes via shortcuts
    playerctl # media control via command line inputs
    networkmanagerapplet # GUI for selecting WiFi in Hyprland
    wlogout
    grim # screenshots
    slurp # screenshots
    dunst
    galculator
  ];
}
