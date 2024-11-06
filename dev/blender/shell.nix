{ pkgs ? import <nixos> { } }:

pkgs.mkShellNoCC {
  packages = with pkgs; [
    blender
    blender-hip # Hardware acceleration for blender
    libGL
    libGLU
    #libX11
    #libXrandr
    #libXi
    #libXxf86vm
  ];
  shellHook = ''
    export DEV_ENVIRONMENT="blender"
    export NIX_SHELL_PATH="$(pwd)"
    source ~/.bashrc
  '';
}
