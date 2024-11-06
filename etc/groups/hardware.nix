{
  hardware = {
    # Update AMD CPU microcode for security
    cpu.amd.updateMicrocode = true;

    # Enable DRI support for OpenGL, 24.05
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      #extraPackages = with pkgs; [ amdvlk ];
      #extraPackages32 = with pkgs; [ amdvlk ];
    };

    # Enable bluetooth
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    #pulseaudio.enable = false;
  };
}
