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
    # # As of NixOs 25.xx this path doesn't exist where the tooling expects it. This is a workaround.
    # extraOptions = ''
    #   --add-runtime=nvidia=${pkgs.nvidia-container-toolkit}/bin/nvidia-container-runtime
    # '';
    # package = pkgs.docker_25;  # ensures CDI support
  };

  networking.firewall.enable = true;

  # Antivirus
  services.clamav.daemon.enable = true;
  services.clamav.updater.enable = true;
}
