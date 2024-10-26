{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05") {} }:

pkgs.mkShellNoCC {
	packages = with pkgs; [
		gimp
		inkscape
		krita
		pixelorama
		#figma-linux
		#figma-agent #font-helper
	];
	shellHook = ''
		export DEV_ENVIRONMENT="art"
		export NIX_SHELL_PATH="$(pwd)"
		source ~/.bashrc
	'';
}
