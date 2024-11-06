{ pkgs ? import <nixos> { } }:

pkgs.mkShellNoCC {
  packages = with pkgs; [
    jetbrains.idea-community
    jdk21
    scenebuilder
    maven
    android-studio
  ];
  shellHook = ''
    export NIXPKGS_ALLOW_UNFREE=1
    export DEV_ENVIRONMENT="java"
    export NIX_SHELL_PATH="$(pwd)"
    source ~/.bashrc
  '';
}

