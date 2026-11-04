{ pkgs }:
{
  packages = with pkgs; [
    git
    gitui
    vim
    wget
  ];
}
