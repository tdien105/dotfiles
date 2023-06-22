{ pkgs, ... }:

{
  homebrew = {
    brews = [
      "pyenv"
      "tfenv"
    ];

    casks = [
      "royal-tsx"
      "remote-desktop-manager"
    ];
  };

  users.users.virtual.home = /Users/virtual;

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.virtual = { pkgs, lib, ... }: {
      home.stateVersion = "22.11";
      programs.home-manager.enable = true;
      home.file.".config/alacritty/alacritty.yml".text = builtins.readFile ../files/alacritty.yml;
      home.file.".config/karabiner/karabiner.json".text = builtins.readFile ../files/karabiner.json;
      home.packages = with pkgs; [
        azure-cli
        kubectx
        sops
        terragrunt
        tflint
        yq-go
        hiera-eyaml
        terraform
      ];
    };
  };
}
