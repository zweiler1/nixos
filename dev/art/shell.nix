{ pkgs ? import <nixos> { } }:

pkgs.mkShellNoCC {
  packages = with pkgs; [
    gimp
    inkscape
    krita
    pixelorama
    #figma-linux
    #figma-agent #font-helper
  ];
  shellHook = ''
    export DEV_ENVIRONMENT="art"
    export NIX_SHELL_PATH="$(pwd)"
    source ~/.bashrc
  '';
}
