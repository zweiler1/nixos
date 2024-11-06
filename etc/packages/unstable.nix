{ pkgs ? import <nixos-unstable> { } }:
{
  packages = with pkgs; [
    zed-editor
    neovim
    git-credential-manager
    git-credential-oauth
  ];
}
