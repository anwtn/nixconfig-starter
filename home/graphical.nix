{ config, pkgs, ... }:

{
  imports = [
    ./fonts.nix
    ./vscode.nix
    ./i3
  ];

  home.packages = with pkgs; [
    # ────── Utilities ──────
    delta
    pavucontrol

    # ────── Browsers & Communication ──────
    firefox
    google-chrome
    slack
    # teams # Marked as insecure 2023-10-18

    # ────── Development / Database ──────
    vscode
    dbeaver-bin
    libheif
    # postman
    # lens
    # sublime

    # ────── Office Suite ──────
    libreoffice-fresh    # Latest stable LibreOffice
    hunspell             # Spell checking engine

    # ────── Spell Dictionaries ──────
    hunspellDicts.en_AU   # Australian / UK English
    hunspellDicts.en_US   # US English
  ];

  # Optional: Environment variables for LibreOffice
  home.sessionVariables = {
    # Ensures LibreOffice uses the correct UI theme on GTK/QT desktops
    QT_STYLE_OVERRIDE = "fusion";
  };
}
