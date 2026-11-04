{ pkgs, ... }:
{
  systemd = {
    user.services.rebuild-ksycoca = {
      description = "Rebuild KDE ksycoca cache (MIME / service types)";
      wantedBy = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = pkgs.writeShellScript "rebuild-ksycoca" ''
          rm -f "$HOME"/.cache/ksycoca6_*
          ${pkgs.kdePackages.kservice}/bin/kbuildsycoca6 --noincremental
        '';
      };
    };
  };
}
