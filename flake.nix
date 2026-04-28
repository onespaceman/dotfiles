{
  description = "My Nixos";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix.url = "github:ryantm/agenix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixos-wsl,
    agenix,
    home-manager,
    plasma-manager,
    ...
  }: {
    nixosConfigurations = {
      mothership = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          agenix.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              sharedModules = [agenix.homeManagerModules.default];
              users.spaceman.imports = [./nix/mothership/home.nix];
            };
          }
          ./nix
          ./nix/mothership
        ];
      };
      ship = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          agenix.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              sharedModules = [plasma-manager.homeModules.plasma-manager];
              users.spaceman.imports = [./nix/ship/home.nix];
            };
          }
          ./nix
          ./nix/ship
        ];
      };
      wsl = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          agenix.nixosModules.default
          home-manager.nixosModules.home-manager
          nixos-wsl.nixosModules.default
          ./nix/base.nix
          {
            wsl = {
              enable = true;
              defaultUser = "spaceman";
              wslConf.interop.appendWindowsPath = false;
            };
            networking.hostName = "wsl";
          }
        ];
      };
    };
  };
}
