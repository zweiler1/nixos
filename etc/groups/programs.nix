{
  programs = {
    # Install firefox.
    firefox.enable = true;

    hyprland = {
      enable = true;
      withUWSM = true; # recommended for most users
      xwayland.enable = true; # Xwayland can be disabled.
    };

    # Enable the GNUPG agent
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    # Enable Git
    git.enable = true;
  };
}
