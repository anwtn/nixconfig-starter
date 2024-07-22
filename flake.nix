{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    repo-nnn = {
      url = "github:jarun/nnn";
      flake = false;
    };
  };
  outputs = { nixpkgs, nixpkgs-unstable, home-manager, repo-nnn, ... }:
    let
      users = {
        me = {
          # CHANGE ME TO YOUR USER
          name = "Aaron Newton";
          username = "aaronnewton";
          homeDirectory = "/home/aaronnewton";
          email = "aaron.newton@playtravel.com.au";
        };
        docker = {
          name = "Docker User";
          username = "root";
          homeDirectory = "/root";
          email = "docker@example.com";
        };
      };
      pkgsForSystem = { system, pkgs ? nixpkgs }: import pkgs {
        inherit system;
        config.allowUnfree = true;

        # Allows you to use an unstable package with pkgs.unstable.<foo>
        # 20240722t1606 AJN - disabling unstable overlays.
        # overlays =
        #   [ (final: prev: { unstable = pkgsForSystem { inherit system; pkgs = nixpkgs-unstable; }; inherit repo-nnn; }) ];
        overlays =
           [ (final: prev: { unstable = pkgsForSystem { inherit system; pkgs = nixpkgs; }; inherit repo-nnn; }) ];
      };
    in
    {
      homeConfigurations = {
        docker = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsForSystem { system = "x86_64-linux"; };
          modules = [
            ./home/default.nix
          ];
          extraSpecialArgs = {
            user = users.docker;
          };
        };
      };
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          pkgs = pkgsForSystem { system = "x86_64-linux"; };
          modules = [
            ./systems/nixos/configuration.nix
            ./systems/common/default.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.aaronnewton = {
                  imports = [
                    ./home/default.nix
                    ./home/graphical.nix
                  ];
                };

                extraSpecialArgs = {
                  user = users.me;
                };
              };
            }
          ];
        };
      };
    };
}
