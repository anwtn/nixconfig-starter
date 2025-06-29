{ config, pkgs, lib, ... }:
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;

    history = {
      ignoreDups = true;
      save = 1000000;
      size = 1000000;
    };

    # initExtra = '' # Deprecated in Nix 25.05 stable.
    initContent = ''
      [ -f $HOME/.nix-profile/etc/profile.d/nix.sh ] && source $HOME/.nix-profile/etc/profile.d/nix.sh
      export PATH=$HOME/source/nixconfig-starter/scripts:$PATH
      export EDITOR=hx
      export GOPATH=$HOME/go
      # Added ~/bin to PATH for Aaron's custom tools, including exercism
      export PATH=~/bin:$PATH
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [
        "aws"
        "docker"
        "direnv"
        "encode64"
        "git"
        "git-extras"
        "kubectl"
        "man"
        "nmap"
        "sudo"
        "systemd"
        "tig"
        "yarn"
        "zsh-navigation-tools"
        "urltools"
      ];
    };
  };
}
