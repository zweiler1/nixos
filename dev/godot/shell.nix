{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05") {} }:

let
	godot43 = pkgs.callPackage /home/zweiler1/gitclones/NixOS_Packages/Godot/godot43.nix {};
in
pkgs.mkShell {
	packages = with pkgs; [
		godot43 # '4.3' with sdl patch
	];
	shellHook = ''
		export DEV_ENVIRONMENT="godot"
		export NIX_SHELL_PATH="$(pwd)"
		source ~/.bashrc
	'';
}
