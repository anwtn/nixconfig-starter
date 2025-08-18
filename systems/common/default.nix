{ config, pkgs, lib, ... }:
{
  # nixpkgs.config.allowUnfree = true;
  nix = {
    package = pkgs.nixVersions.latest;
    settings.auto-optimise-store = true;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # virtualisation.docker.enable = true;
  # Docker with GPU
  virtualisation.docker = {
    enable = true;
    enableNvidia = true; # this hooks docker with nvidia runtime
  };

  networking.firewall.enable = true;

  # Antivirus
  services.clamav.daemon.enable = true;
  services.clamav.updater.enable = true;
}
