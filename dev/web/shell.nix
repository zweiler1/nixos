{ pkgs ? import <nixos> { } }:

pkgs.mkShellNoCC {
  packages = with pkgs; [
    php
  ];
  shellHook = ''
    export DEV_ENVIRONMENT="web"
    export NIX_SHELL_PATH="$(pwd)"
    source ~/.bashrc

    alias connect-zs="ssh zweiler2@zweilerserver.ddns.net"
  '';
}
