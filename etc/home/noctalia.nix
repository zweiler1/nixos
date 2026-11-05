{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia = {
    enable = true;

    package = pkgs.noctalia;

    settings = {
      # Configuration of noctalia
    };
  };
}
