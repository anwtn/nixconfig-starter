{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    repo-nnn = {
      url = "github:jarun/nnn";
      flake = false;
    };
  };
  outputs = { nixpkgs, nixpkgs-unstable, home-manager, ... }:
    let
      users = {
        me = {
          # CHANGE ME TO YOUR USER
          name = "Victor Gutierrez";
          username = "victor";
          homeDirectory = "/home/victor";
          email = "victor.gutierrez@playtravel.com.au";
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
        overlays =
          [ (final: prev: { unstable = pkgsForSystem { inherit system; pkgs = nixpkgs-unstable; }; }) ];
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
                # CHANGE 'victor' TO YOUR USERNAME
                users.victor = {
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
