{ config, pkgs, user, ... }:
{
  imports = [
    ./i3
  ];

  home.packages = with pkgs.unstable; [
    awscli2
    # clamav
    fd
    docker-compose
    inkscape
    imagemagick
    kubectl
    mkcert
    nodejs-18_x
    openvpn
    pciutils
    stripe-cli
    tmux
    unzip
    wget
    zip
    sd
    meld
    p7zip
    mariadb
    postgresql
    discord
    lsof
    jq
    ncdu
  ];
}
