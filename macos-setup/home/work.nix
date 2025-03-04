{ pkgs, ... }:

{
  homebrew = {
    brews = [
      "tfenv"
      "freetds"
      "cython"
      "openssl"
      "mysql-client"
      "mysql@8.0"
      "gh"
      "cmctl"
      "tox"
      "pinentry"
    ];

    casks = [
      "remote-desktop-manager"
      "1password"
      "1password-cli"
      "sublime-text"
      "notion"
      "openkey"
      "telegram"
      "alacritty" # TODO https://github.com/neovim/neovim/issues/3344
      "utm"
      "visual-studio-code"
      "zalo"
      "kitty"
    ];
  };

  users.users.dphan.home = /Users/dphan;
  # #keyboard settings
  # system.defaults.NSGlobalDomain.InitialKeyRepeat = 3; #This sets how long you must hold down the key before it starts repeating.
  # system.defaults.NSGlobalDomain.KeyRepeat = 1; #This sets how fast it repeats once it starts.
  system.defaults.trackpad.TrackpadThreeFingerDrag = true;
  system.defaults.dock.minimize-to-application = true;
  system.defaults.dock.orientation = "left";
  system.defaults.NSGlobalDomain.AppleEnableSwipeNavigateWithScrolls = true;

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.dphan = { pkgs, lib, ... }: {
      manual.manpages.enable = false;
      home.stateVersion = "22.11";
      programs.home-manager.enable = true;
      # home.file.".config/alacritty/alacritty.yml".text = builtins.readFile ../files/alacritty.toml;
      # home.file.".config/karabiner/karabiner.json".text = builtins.readFile ../files/karabiner.json;
      home.packages = with pkgs; [
        azure-cli
        kubectx
        sops
        terragrunt
        tflint
        yq-go
        hiera-eyaml
        sqlcmd
        kubelogin
        cabextract
        wimlib
        cdrtools
        chntpw
        gawk
        pwgen
        powershell
        sshpass
        tfk8s
      ];
    };
  };
}
