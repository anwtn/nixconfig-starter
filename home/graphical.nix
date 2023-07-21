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
    teams
    libheif
    postman
    dbeaver
    lens
    pavucontrol
    spotify
    sublime
  ];
}
