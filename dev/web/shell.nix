{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05") {} }:

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
