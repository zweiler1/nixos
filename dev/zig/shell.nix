{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-unstable") {} }:

pkgs.mkShellNoCC {
	packages = with pkgs; [
		zig
		zed-editor
	];
	shellHook = ''
		export DEV_ENVIRONMENT="zig"
		export NIX_SHELL_PATH="$(pwd)"
		source ~/.bashrc
	'';
}
