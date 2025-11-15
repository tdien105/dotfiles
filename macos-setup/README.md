# macOS Nix Configuration

## 📁 Structure

```
macos-setup/
├── flake.nix                      # Flake entry point
├── flake.lock                     # Locked dependencies
├── Makefile                       # Build automation
└── hosts/
    └── work.nix                   # Complete configuration for work machine
                                   # Everything in one place:
                                   # - System packages
                                   # - Homebrew (brews & casks)
                                   # - System defaults (dock, trackpad, etc)
                                   # - Fonts
                                   # - Nix settings
                                   # - User packages (home-manager)
```

## 🚀 Quick Start

### First-Time Setup

1. **Install Nix** (if not already installed):
   ```bash
   curl -L https://nixos.org/nix/install | sh
   ```

2. **Install nix-darwin**:
   ```bash
   nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
   yes | ./result/bin/darwin-installer
   ```

3. **Install Homebrew** (if not already installed):
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

4. **Build and apply configuration**:
   ```bash
   cd ~/macos-setup
   make build
   ```

### Daily Usage

```bash
# Rebuild and switch to new configuration
darwin-rebuild switch --flake .

# Or use the Makefile
make build

# Update flake inputs (nixpkgs, home-manager, etc.)
make update
```

## 📦 What's Included

### System Packages
- Development tools: git, neovim, docker, cargo, go, nodejs
- CLI utilities: bat, ripgrep, fd, jq, kubectl, helm, zoxide, tree
- Networking: curl, mosh

### User Packages (home-manager)
- Cloud: azure-cli, terraform, terragrunt
- Kubernetes: kubectl, kubectx, kubelogin
- Database: sqlcmd
- DevOps: sops, tflint, powershell, tfk8s
- Languages: lua-language-server, terraform-ls

### Homebrew Brews
- tfenv, pyenv, asdf, fzf, gh, prettier
- mysql-client, openssl, pinentry
- python@3.11, cython, freetds

### Homebrew Casks
- Editors: VS Code, Sublime Text
- Terminals: Alacritty, Kitty
- Productivity: Notion, OneNote, 1Password
- Communication: Telegram, Zalo
- Development: UTM, Remote Desktop Manager

### System Defaults
- Dark mode enabled
- Dock: left side, auto-hide disabled, show hidden apps
- Keyboard: no press-and-hold, fast key repeat
- Disabled: auto-capitalization, smart quotes, spell correction
- Touch ID for sudo enabled
- Three-finger drag enabled

## 🔧 Customization

### Adding System Packages

Edit `hosts/work.nix`, find the `environment.systemPackages` section:
```nix
environment.systemPackages = with pkgs; [
  # ... existing packages ...
  your-new-package
];
```

### Adding User Packages

Edit `hosts/work.nix`, find the `home-manager.users.dphan` section:
```nix
home.packages = with pkgs; [
  # ... existing packages ...
  your-new-package
];
```

### Adding Homebrew Casks or Brews

Edit `hosts/work.nix`, find the `homebrew` section:
```nix
homebrew = {
  brews = [
    # ... existing brews ...
    "new-brew"
  ];
  
  casks = [
    # ... existing casks ...
    "new-app"
  ];
};
```

### Changing System Settings

Edit `hosts/work.nix`, find the `system.defaults` section and modify as needed.

### Adding Dotfiles

In the `home-manager.users.dphan` section, add file configurations:
```nix
home.file.".config/app/config.conf".text = ''
  # Your config content here
'';

# Or reference an external file:
home.file.".config/app/config.conf".source = ./dotfiles/config.conf;
```

### Adding a New Host

1. Create `hosts/NEW-HOSTNAME.nix` by copying and modifying `hosts/work.nix`
2. Update `flake.nix`:
   ```nix
   darwinConfigurations = {
     "work" = darwin.lib.darwinSystem { ... };
     
     "NEW-HOSTNAME" = darwin.lib.darwinSystem {
       system = "aarch64-darwin";  # or "x86_64-darwin"
       modules = [
         ./hosts/NEW-HOSTNAME.nix
         home-manager.darwinModules.home-manager
       ];
       specialArgs = { inherit nixpkgs darwin home-manager; };
     };
   };
   ```

## 🔍 Search for Packages

```bash
# Search on NixOS search website
# Visit: https://search.nixos.org/

# Or use command line
nix search nixpkgs package-name
```

## 🐛 Troubleshooting

### Build fails?
```bash
# Check syntax
nix flake check

# Try with verbose output
darwin-rebuild switch --flake . --show-trace
```

### Want to rollback?
```bash
# List previous generations
darwin-rebuild --list-generations

# Rollback to previous
darwin-rebuild --rollback
```

### Homebrew not working?
```bash
# Make sure it's installed
/opt/homebrew/bin/brew --version

# Reinstall a cask
brew reinstall --cask app-name
```

## 📚 Resources

- [nix-darwin Documentation](https://github.com/LnL7/nix-darwin)
- [home-manager Manual](https://nix-community.github.io/home-manager/)
- [NixOS Search](https://search.nixos.org/) - Search for packages
- [Nix Darwin Options](https://daiderd.com/nix-darwin/manual/index.html)

## 📝 Notes

- **State Version**: Keep `system.stateVersion = 4` as is (for backwards compatibility)
- **Flake Inputs**: Pinned to release-25.05 branch
- **GID Change**: nixbld group GID changed from 30000 to 350 in 25.05
- **Single File**: Everything for your machine is in one file (`hosts/work.nix`)

## 💡 Pro Tips

1. **Test before applying**: Always use `build` before `switch`
2. **Commit changes**: Keep your config in git
3. **Use flake inputs**: Update regularly with `nix flake update`
4. **Check generations**: You can always rollback
5. **Read the trace**: Use `--show-trace` for detailed errors
6. **One file per host**: Keep it simple - all config in one place

## 🔄 Migration from Old Structure

The old monolithic `config.nix` has been consolidated into `hosts/work.nix`.

Old files can be removed after verifying the new setup works:
```bash
rm config.nix home/work.nix home/test.nix
rmdir home
```
