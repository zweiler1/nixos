#!/bin/sh

# This script sets up the nix environment for me
# It can only run with sudo rights, so first check if this shell script is run with sudo rights
if [ "$EUID" -ne 0 ]; then
  echo "Script must be run with sudo"
  exit 1
fi

# Setting up the nixos environment configuration
# First, delete everything inside the /etc/nixos/ directory
rm -r /etc/nixos/*
# Create the directories 'groups' and 'packages' in /etc/nixos/
mkdir /etc/nixos/groups
mkdir /etc/nixos/packages

# Make hard links of every file inside the ./etc directory
ln ./etc/configuration.nix /etc/nixos/configuration.nix
ln ./etc/hardware-configuration.nix /etc/nixos/hardware-configuration.nix
ln ./etc/shell-commands.nix /etc/nixos/shell-commands.nix

# Linking the groups
ln ./etc/groups/hardware.nix /etc/nixos/groups/hardware.nix
ln ./etc/groups/programs.nix /etc/nixos/groups/programs.nix
ln ./etc/groups/services.nix /etc/nixos/groups/services.nix

# Linking the packages
ln ./etc/packages/pkgs.nix /etc/nixos/packages/pkgs.nix
ln ./etc/packages/unstable.nix /etc/nixos/packages/unstable.nix
ln ./etc/packages/hyprland.nix /etc/nixos/packages/hyprland.nix
ln ./etc/packages/kdePackages.nix /etc/nixos/packages/kdePackages.nix

# Make hard links of all dev environment nix-shells
mkdir ~/env
for d in *; do
	if [ -d "$d" ]; then
		mkdir "~/env/$d"
		ln "./env/$d/shell.nix" "~/env/$d/shell.nix"
	fi
done
