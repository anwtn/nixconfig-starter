{
  config,
  pkgs,
  user,
  ...
}: {
  imports = [
    ./nnn
    ./mime.nix
    ./k9s
    ./lazygit
    ./zellij
    ./alacritty
    ./helix
    ./packages.nix
    ./direnv.nix
    ./git.nix
    ./bash.nix
    ./zsh.nix
    ./nvim.nix
    ./lsp.nix
    ./starship.nix
  ];

  home.packages = with pkgs; [
    awscli2
    docker-compose
    pciutils
    unzip
    wget
    zip
    openvpn
    vim
    meld
    lsof
    clamav
    kubectl
    k9s
    postman
  ];

  home.username = user.username;
  home.homeDirectory = user.homeDirectory;
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
}
