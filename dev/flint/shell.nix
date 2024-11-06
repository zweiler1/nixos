{ pkgs ? import <nixos-unstable> { } }:

pkgs.mkShellNoCC {
  packages = with pkgs; [
    llvm_18
    clang_18
    libclang
    libcxx # c++ standard library
    gcc
  ];
  shellHook = ''
    export DEV_ENVIRONMENT="flint"
    export NIX_SHELL_PATH="$(pwd)"
    export LLVM_INCLUDE_DIR="$(llvm-config --includedir)"
    export LIBCLANG_PATH="${pkgs.libclang}/lib"
    source ~/.bashrc
    alias cdx="cd $NIX_SHELL_PATH"

    alias build-flint="$NIX_SHELL_PATH/flint/"
    alias build-calculator="$NIX_SHELL_PATH/resources/calculator/build.sh"
    alias run-calculator="$NIX_SHELL_PATH/resources/calculator/calculator"
    alias build-tutorial="$NIX_SHELL_PATH/resources/tutorial/kaleidoscope/src/builder.sh"
    alias run-tutorial="$NIX_SHELL_PATH/resources/tutorial/kaleidoscope/src/main"
  '';
}
