{
  programs.bash = {
    shellAliases = {
      #ls = "ls -lah --color=tty";
      nix-clean = "sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
      upd = "sudo nixos-rebuild switch --upgrade";
      upg = "sudo nixos-rebuild switch --upgrade-all";
      nixedit = "nvim /etc/nixos/configuration.nix";
      shelledit = "nvim /etc/nixos/shell_commands.nix";
      GpuI = "supergfxctl -m Integrated && sudo reboot now";
      GpuH = "supergfxctl -m Hybrid && sudo reboot now";
      GpuD = "supergfxctl -m AsusMuxDgpu && sudo reboot now";
      GpuNow = "supergfxctl -g";
      use_dgpu = "DRI_PRIME=pci-0000_03_00_0";
      use_igpu = "DRI_PRIME=pci-0000_77_00_0";
      pwr_quiet = "asusctl profile -P Quiet";
      pwr_balanced = "asusctl profile -P Balanced";
      pwr_performance = "asusctl profile -P Performance";
      pwr_now = "asusctl profile -p";
    };
    interactiveShellInit = ''
      # List all available dev environments
      lsdev() {
              echo "The following environments are available:"
              for file in $ENV_PATH/*; do
                      echo " - $(basename "$file")"
              done
      }


      # Check if a given dev environment does exist
      dev_env_exists() {
              if [ "$1" = "" ]; then
                      echo "Enter a dev environment name first!"
                      return 1
              fi
              if ! [ -d $ENV_PATH/"$1" ]; then
                      echo "The dev environment '$1' does not exist!"
                      lsdev
                      return 1
              fi
              return 0
      }


      # Create a new dev environment with the shell.nix file already set up
      mkdev() {
              if [ "$1" = "" ]; then
                      echo "You have to enter a dev environment name to be able to create one!"
                      return 1
              fi
              if [ -d ~/NC/env/"$1" ]; then
                      echo "Dev environment '$1' already exists!"
                      return 1
              fi

              mkdir "$ENV_PATH/$1"
              touch "$ENV_PATH/$1/shell.nix"
              cat /etc/nixos/default_shell.nix | tee "$ENV_PATH/$1/shell.nix"
              sed -i "s/DEV_ENVIRONMENT=\"[^\"]*\"/DEV_ENVIRONMENT=\"$1\"" "$ENV_PATH/$1/shell.nix"
              echo "Successfully created dev env '$1'"
      }


      # Edit the shell.nix file for an already existent dev environment
      dev_edit() {
              dev_env_exists "$1" || return 1
              nvim "$ENV_PATH/$1/shell.nix"
      }


      # Change the nix dev env to a given environment, but only existing environments can be chosen
      dev() {
              dev_env_exists "$1" || return 1

              oldPath="$(pwd)"
              cd $ENV_PATH/"$1"
              kitten @ set-tab-title "$1"
              if [ "$2" = "-c" ]; then
                      cached-nix-shell
              else
                      nix-shell
              fi

              kitten @ set-tab-title $tab_title_template
              cd "$oldPath"
              return 0
      }


      # Count all lines of all files from the given directory recursively
      cl() {
              if [ "$1" = "" ]; then
                      dir="./"
              else
                      dir="$1"
              fi
              find "$dir" -type f -exec wc -l {} \; | cut -d ' ' -f1 | sed 's/$/+/g' | tr -d '\n' | sed 's/+$/\n/' | bc
      }


      # Turn on / off the screen
      toggle_screen() {
        if [ $(hyprctl monitors ... | grep -q "dpmsStatus: ." | sed -e "s/dpmsStatus: \(.\)/\1/") ]; then
                hyprctl dispatch dpms on
        else
                hyprctl dispatch dpms off
        fi
      }
    '';
  };
}
