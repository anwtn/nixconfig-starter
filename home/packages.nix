{ config, pkgs, user, ... }:
{
  home.packages = with pkgs.unstable; [
    awscli2
    clamav
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
  ];
}
