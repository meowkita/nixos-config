{
  description = "Personal NixOS fleet and exploration environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, zen-browser }: {
    nixosConfigurations = {

      # > The first machine transitioned to NixOS and Niri
      # A portable exploration node used for experimentation
      # and day-to-day navigation
      traveler = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/traveler/configuration.nix

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.meowkita = import ./hosts/traveler/home.nix;
          }
        ];
      };

      # > Primary workstation and heavy compute node
      # Used for gaming, multimedia workloads, 
      # development and long-running sessions
      atlas = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/atlas/configuration.nix

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.meowkita = import ./hosts/atlas/home.nix;
          }
        ];
      };

      # > Remote infrastructure relay
      # Hosts self-managed services, secrets and persistent containers:
      # vaultwarden, gitea, registry, automation and internal tooling
      anomaly = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/anomaly/configuration.nix

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.meowkita = import ./hosts/anomaly/home.nix;
          }
        ];
      };
      
    };      
  };
}
