{
  description = "MacOS setup with modular nix-darwin and home-manager";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/release-25.05";
    };
    darwin = {
      url = "github:lnl7/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, darwin, home-manager }: {
    darwinConfigurations = {
      "AM-G752H4T49P" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./hosts/work.nix
          home-manager.darwinModules.home-manager
        ];
        specialArgs = { inherit nixpkgs darwin home-manager; };
      };
    };
  };
}
