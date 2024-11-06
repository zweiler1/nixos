{
  services = {
    # Configure keymap in X11
    xserver.xkb = {
      layout = "at";
      variant = "";
    };

    # Enable SDDM
    displayManager.sddm = {
      wayland.enable = true;
      enable = true;
      theme = "sddm-sequoia";
    };

    # Enable sound with pipewire.
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      jack.enable = true;
      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

    # Enable the OpenSSH daemon.
    openssh.enable = true;

    # Enable pinentry for gnupg
    pcscd.enable = true;

    # Enable supergfxctl daemon
    supergfxd.enable = true;
    asusd = {
      enable = true;
      enableUserService = true;
    };

    # Udisks2 is a linux utility for disk operations (needed by dolphin)
    udisks2.enable = true;

    # Enable the bluetooth snippet
    blueman.enable = true;
  };
}
