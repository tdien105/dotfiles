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
      "AS-DQQQ4VJH9Y" = darwin.lib.darwinSystem { #working machine
        system = "aarch64-darwin";
        modules = [
          ./config.nix
          home-manager.darwinModules.home-manager
          ./home/work.nix
        ];
        inputs = { inherit nixpkgs darwin home-manager; };
      };
      "192" = darwin.lib.darwinSystem { #tesing machine
        system = "aarch64-darwin";
        modules = [
          ./config.nix
          home-manager.darwinModules.home-manager
          ./home/test.nix
        ];
        inputs = { inherit nixpkgs darwin home-manager; };
      };
    };
  };
}
