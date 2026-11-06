{ pkgs }:
{
  packages = with pkgs; [
    gawk
    bash
    binutils
    coreutils
    curl
    diffutils
    findutils
    gnugrep
    jq
    openssh
    rsync
    gnused
    util-linux
    btrfs-progs
  ];
}
