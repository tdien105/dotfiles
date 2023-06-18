{ pkgs, ... }:

{
  homebrew = {
    casks = [
      "royal-tsx"
      "remote-desktop-manager"
    ];
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.dphan = { pkgs, lib, ... }: {
      home.stateVersion = "22.11";
      programs.home-manager.enable = true;
      home.file.".config/alacritty/alacritty.yml".text = builtins.readFile ../app-configs/alacritty.yml;
      home.file.".config/karabiner/karabiner.json".text = builtins.readFile ../app-configs/karabiner.json;
      home.packages = with pkgs; [
        azure-cli
        kubectx
        sops
        terragrunt
        tflint
        yq-go
        hiera-yaml
      ];
    };
  };
}
