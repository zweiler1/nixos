{ pkgs }:
{
  packages = with pkgs; [
    gitui
    vim
    wget
    fzf

    neovim
    gcc
    unzip
    clang-tools
    stylua
    tree-sitter
    luaPackages.tree-sitter-cli
  ];
}
