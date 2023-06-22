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
      "1password"
      "microsoft-onenote"
      "notion"
      "openkey"
      "logitech-options"
    ];
  };

  users.users.virtual.home = /Users/dphan;

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.dphan = { pkgs, lib, ... }: {
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
        sublime4
        spotify
        telegram-desktop
      ];
    };
  };
}
