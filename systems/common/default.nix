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
    # enableNvidia = true; # this hooks docker with nvidia runtime. Removed in NixOS 25.05
    # # As of NixOs 25.xx this path doesn't exist where the tooling expects it. This is a workaround.
    # GPU support is now handled entirely via the NVIDIA container toolkit
    extraOptions = ''
      --add-runtime=nvidia=${pkgs.nvidia-container-toolkit}/bin/nvidia-container-runtime
    '';
    # package = pkgs.docker_25;  # ensures CDI support
    # enableBuildkit = true; # optional, faster builds  docker-compose
    # defaultRuntime = "nvidia";
  };

  networking.firewall.enable = true;

  # Antivirus
  services.clamav.daemon.enable = true;
  services.clamav.updater.enable = true;
}
