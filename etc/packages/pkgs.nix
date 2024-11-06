{ pkgs }:

let
  # Fetch the SDDM Theme from GitHub
  sddmSequoia = pkgs.stdenv.mkDerivation {
    pname = "sddm-sequoia";
    version = "latest";

    src = pkgs.fetchFromGitHub {
      owner = "minMelody";
      repo = "sddm-sequoia";
      rev = "main";
      sha256 = "sha256-UEo/CBQUq6y22tt4+VSPTRYYwYPcTK+PAZHGG/VV7WA=";
    };

    installPhase = ''
      mkdir -p $out/share/sddm/themes/sddm-sequoia
      cp -r * $out/share/sddm/themes/sddm-sequoia
    '';
  };
in
{
  packages = with pkgs; [
    # System and Terminal packages
    wget
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #neovim # Moved to unstable packages
    lf
    fzf
    killall
    smartmontools
    libva-utils
    shared-mime-info # Myme type database
    supergfxctl
    asusctl
    mesa
    #pv # progress viewer through pipes

    # GIT
    git
    #git-credential-oauth
    #git-credential-manager
    dotnet-sdk_7 # Needed by the git-credential-manager
    fontconfig
    freetype
    #libSkiaSharp
    gnupg
    pinentry-curses # Needed by gpg to sign commits

    # NIX
    #home-manager

    # NVIM Dependencies
    gcc # c/cpp compiler
    ripgrep
    gnumake
    unzip
    cargo

    # Applications
    kitty
    firefox
    nextcloud-client
    webcord
    whatsapp-for-linux

    # QT & KDE & SDDM
    qt5.qtwayland # Provides QT Support for wayland
    libsForQt5.qt5.qtgraphicaleffects # Provides graphical effects for QT5 for sddm
    plymouth
    udisks # needed by dolphin for block disk devices
    sddmSequoia # The custom sddm theme declared above

    # Gaming Related
    heroic
    lutris
    mangohud
    wineWowPackages.stable
    winetricks
    protonup-qt
  ];
}
