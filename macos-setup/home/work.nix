{ pkgs, ... }:

{
  homebrew = {
    brews = [
      "pyenv"
      "tfenv"
    ];

    casks = [
      "remote-desktop-manager"
      "viscosity"
      "slack"
      "1password"
      "1password-cli"
      "zoom"
      "sublime-text"
      "notion"
      "microsoft-onenote"
      "microsoft-word"
      "microsoft-excel"
      "microsoft-outlook"
      "microsoft-powerpoint"
      "spotify"
      "openkey"
      "logitech-options"
      "telegram"
      "alacritty" # TODO https://github.com/neovim/neovim/issues/3344
      "brave-browser"
      "utm"
      "visual-studio-code"
    ];
  };

  users.users.dphan.home = /Users/dphan;
  # #keyboard settings
  # system.defaults.NSGlobalDomain.InitialKeyRepeat = 3; #This sets how long you must hold down the key before it starts repeating.
  # system.defaults.NSGlobalDomain.KeyRepeat = 1; #This sets how fast it repeats once it starts.
  # system.defaults.trackpad.Dragging = true;
  # system.defaults.trackpad.TrackpadThreeFingerDrag = true;

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.dphan = { pkgs, lib, ... }: {
      manual.manpages.enable = false;
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
