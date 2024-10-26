{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05") {} }:

pkgs.mkShellNoCC {
	packages = with pkgs; [
		texstudio
		texliveFull # all contains all macro programs for tex
		jupyter-all # needed because otherwise latex converting to pdf wont work
		python311Packages.pygments
		# to fix the error "you must envoke ... with the '--shell-escape' flag the following has to be done:
			# https://tex.stackexchange.com/questions/99475/how-to-invoke-latex-with-the-shell-escape-flag-in-texstudio-former-texmakerx
		# In TeXstudio go to 'Options > Configure TeXStudio > Commands' and change
			# pdflatex -synctex=1 -interaction=nonstopmode %.tex
		# to
			# pdflatex -synctex=1 -interaction=nonstopmode --shell-escape %.tex
		# this will fix the problem and the pdf should be able to render correctly afterwards
	];
	shellHook = ''
		export DEV_ENVIRONMENT="tex"
		export NIX_SHELL_PATH="$(pwd)"
		source ~/.bashrc
	'';
}
