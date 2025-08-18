{
  inputs = {
    # Use the latest stable nixpkgs for the 24.05 release
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    # Home Manager matching nixpkgs 24.05
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      # Define user configurations
      users = {
        me = {
          name = "Aaron Newton";
          username = "aaronnewton";
          homeDirectory = "/home/aaronnewton";
          email = "aaron.newton@gmail.com";
        };
        docker = {
          name = "Docker User";
          username = "root";
          homeDirectory = "/root";
          email = "docker@example.com";
        };
      };

      # Function to create pkgs for a specific system
      pkgsForSystem = { system }: import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
    in {
      # Define Home Manager configurations
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

      # Define NixOS configurations
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
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
                backupFileExtension = "backup_20250818t1820";
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
