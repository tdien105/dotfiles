{
  description = "MacOS setup";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, darwin, home-manager }: {
    darwinConfigurations = {
      "SGN-DQQQ4VJH9Y" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./config.nix
          home-manager.darwinModules.home-manager
          ./sys-configs/axon.nix
        ];
        inputs = { inherit nixpkgs darwin home-manager; };
      };
    };
  };
}
