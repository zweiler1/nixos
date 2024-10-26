{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05") {} }:

pkgs.mkShellNoCC {
	packages = with pkgs; [
		rnote
		xournal
		lorien
		p3x-onenote
	];
	shellHook = ''
		export DEV_ENVIRONMENT="note"
		export NIX_SHELL_PATH="$(pwd)"
		source ~/.bashrc
	'';
}
