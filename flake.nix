{
  description = "My Nixos";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixos-wsl,
      home-manager,
      plasma-manager,
      ...
    }:
    {
      nixosConfigurations = {
        ship = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./nix/base.nix
            ./nix/ship
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.sharedModules = [ plasma-manager.homeModules.plasma-manager ];
              home-manager.users.spaceman.imports = [
                ./nix/home.nix
                ./nix/ship/home.nix
              ];
            }
          ];
        };
        wsl = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
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
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.spaceman.imports = [
                ./nix/home.nix
              ];
            }
          ];
        };
      };
    };
}
