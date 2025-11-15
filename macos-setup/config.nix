{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep curl
  environment.systemPackages = with pkgs; [
    aria
    bat
    cargo
    curl
    direnv
    docker
    fd
    git
    gnupg
    go
    jq
    kubectl
    kubernetes-helm
    kustomize
    mosh
    neovim
    nnn
    nodePackages.npm
    nodePackages.yarn
    nodejs
    rbw
    ripgrep
    tree
    unzip
    watch
    zoxide
  ];

  environment.systemPath = [
    config.homebrew.brewPrefix # TODO https://github.com/LnL7/nix-darwin/issues/596
  ];

  fonts = {
    packages = with pkgs; [
      nerd-fonts.fira-code
    ];
  };

  # Homebrew packages
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    taps = [
      # { name = "homebrew/cask"; }
    ];
    brews = [
      # "foobar"
    ];
    casks = [
      #foobar
    ];
  };

  system.defaults = {
    alf = {
      globalstate = 1;
    };
    dock = {
      autohide = false;
      minimize-to-application = true;
      mru-spaces = false;
      showhidden = true;
    };
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      AppleKeyboardUIMode = 3;
      ApplePressAndHoldEnabled = false;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
    };
  };

  # services.karabiner-elements = {
  #   enable = true;
  # };

  # Set primary user for system defaults
  system.primaryUser = "dphan";

  # Fix GID for nixbld group (changed from 30000 to 350 in 25.05)
  ids.gids.nixbld = 350;

  nix = {
    # configureBuildUsers = true;
    optimise.automatic = true;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      allowed-users = [
        "@admin"
      ];
    };
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh = {
    enable = true;
    enableBashCompletion = false;
    enableCompletion = false;
    promptInit = "";
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;


}
