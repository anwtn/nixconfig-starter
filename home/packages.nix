{ config, pkgs, user, ... }:
{
  imports = [
    ./i3
  ];

  home.packages = with pkgs; [
    awscli2
    clamav
    fd
    docker-compose
    inkscape
    imagemagick
    kubectl
    mkcert
    # nodejs-18_x
    nodejs_20
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
    btop
  ];
}
