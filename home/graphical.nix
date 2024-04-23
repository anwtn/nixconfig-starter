{ config, pkgs, user, ... }:
{
  imports = [
    ./fonts.nix
    ./vscode.nix
    ./i3
  ];
  home.packages = with pkgs; [
    delta
    firefox
    google-chrome
    slack
    vscode
  # teams # Marked as insecure 2023-10-18
    libheif
    # postman
    dbeaver
    # lens
    pavucontrol
    # spotify
    # sublime
  ];
}
