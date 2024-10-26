{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05") { } }:

pkgs.mkShellNoCC {
  packages = with pkgs; [

  ];
  shellHook = ''
    export DEV_ENVIRONMENT="zig"
    export NIX_SHELL_PATH="$(pwd)"
    source ~/.bashrc
  '';
}
