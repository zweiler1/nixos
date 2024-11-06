{
  programs = {
    # Enable binaries to be executable
    nix-ld = {
      enable = true;
      libraries = [ ];
    };

    # Enable Steam
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };

    # Enable Hyprland
    hyprland = {
      enable = true;
      #  package = pkgs.hyprland;
    };

    # Enable Waybar
    waybar.enable = true;

    # Enable KDE Connect
    kdeconnect.enable = true;

    # Enable the GNUPG agent
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    # GIT Stuff
    git.enable = true;
  };
}
