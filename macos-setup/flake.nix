{
  description = "MacOS setup";

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
      "AM-G752H4T49P" = darwin.lib.darwinSystem { #working machine
        system = "aarch64-darwin";
        modules = [
          ./config.nix
          home-manager.darwinModules.home-manager
          ./home/work.nix
        ];
        inputs = { inherit nixpkgs darwin home-manager; };
      };
    };
  };
}
