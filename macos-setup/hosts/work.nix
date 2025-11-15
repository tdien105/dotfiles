{ config, pkgs, ... }:

{
  # Allow unfree packages (needed for Terraform, 1Password, etc.)
  nixpkgs.config.allowUnfree = true;

  # User account
  users.users.dphan.home = /Users/dphan;
  system.primaryUser = "dphan";

  # SYSTEM PACKAGES
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

  # HOMEBREW
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    
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
      "pyenv"
      "fzf"
      "asdf"
      "python@3.11"
      "prettier"
    ];

    casks = [
      "remote-desktop-manager"
      "1password"
      "1password-cli"
      "sublime-text"
      "notion"
      "openkey"
      "telegram"
      "alacritty"
      "utm"
      "visual-studio-code"
      "zalo"
      "kitty"
      "microsoft-onenote"
    ];
  };

  # Add homebrew to system path
  environment.systemPath = [
    config.homebrew.brewPrefix
  ];

  # FONTS
  fonts = {
    packages = with pkgs; [
      nerd-fonts.fira-code
    ];
  };

  # SYSTEM DEFAULTS
  system.defaults = {
    # Firewall
    alf = {
      globalstate = 1;
    };

    # Dock
    dock = {
      autohide = false;
      minimize-to-application = true;
      mru-spaces = false;
      showhidden = true;
      orientation = "left";
    };

    # Trackpad
    trackpad = {
      TrackpadThreeFingerDrag = true;
    };

    # Global domain
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      AppleKeyboardUIMode = 3;
      ApplePressAndHoldEnabled = false;
      AppleEnableSwipeNavigateWithScrolls = true;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
    };
  };

  # SECURITY
  security.pam.services.sudo_local.touchIdAuth = true;

  # NIX CONFIGURATION
  nix = {
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

  # Fix GID for nixbld group (changed from 30000 to 350 in 25.05)
  ids.gids.nixbld = 350;

  # PROGRAMS
  programs.zsh = {
    enable = true;
    enableBashCompletion = false;
    enableCompletion = false;
    promptInit = "";
  };

  # HOME-MANAGER (USER PACKAGES & DOTFILES)
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    
    users.dphan = { pkgs, lib, ... }: {
      home.stateVersion = "22.11";
      manual.manpages.enable = false;
      programs.home-manager.enable = true;

      # User packages
      home.packages = with pkgs; [
        # Common DevOps tools
        kubectx
        sops
        terragrunt
        tflint
        yq-go
        hiera-eyaml
        terraform
        
        # Cloud & Infrastructure
        azure-cli
        sqlcmd
        kubelogin
        
        # System utilities
        cabextract
        wimlib
        cdrtools
        chntpw
        gawk
        pwgen
        sshpass
        inetutils
        
        # Development tools
        powershell
        tfk8s
        lua-language-server
        terraform-ls
      ];

      # Starship prompt - config is managed in ~/.config/starship.toml
      programs.starship = {
        enable = true;
        enableZshIntegration = true;
      };
    };
  };

  # SYSTEM STATE VERSION
  system.stateVersion = 4;
}
