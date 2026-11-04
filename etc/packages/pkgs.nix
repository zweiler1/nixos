{ pkgs }:
{
  packages = with pkgs; [
    gitui
    vim
    wget
    fzf
  ];
}
