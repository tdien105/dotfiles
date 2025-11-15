.POSIX:
.PHONY: default build switch update clean check help

# Default target - build and apply
default: switch

# Help information
help:
	@echo "macOS Nix Configuration - Available targets:"
	@echo ""
	@echo "  make          - Build and apply configuration (default)"
	@echo "  make switch   - Build and apply configuration"
	@echo "  make build    - Build only without applying (test mode)"
	@echo "  make update   - Update flake inputs (nixpkgs, home-manager, etc.)"
	@echo "  make check    - Validate flake syntax"
	@echo "  make clean    - Remove build artifacts"
	@echo "  make help     - Show this help message"
	@echo ""
	@echo "Current structure:"
	@echo "  flake.nix → hosts/work.nix"

# Build configuration without applying (test mode)
build:
	@echo "🔨 Building configuration for AM-G752H4T49P (test mode)..."
	nix --experimental-features 'nix-command flakes' build .#darwinConfigurations.AM-G752H4T49P.system
	@echo "✅ Build successful! (not applied)"

# Build and apply configuration
switch:
	@echo "🚀 Building and applying configuration..."
	@nix --experimental-features 'nix-command flakes' build .#darwinConfigurations.AM-G752H4T49P.system
	@echo "✅ Build successful! Applying..."
	@echo "💡 Note: You may be prompted for your sudo password"
	@sudo darwin-rebuild switch --flake .
	@echo "✅ Configuration applied successfully!"

# Update flake inputs
update:
	@echo "📦 Updating flake inputs..."
	nix flake update
	@echo "✅ Flake inputs updated!"
	@echo "💡 Run 'make build' to test the updates."

# Check flake syntax
check:
	@echo "🔍 Checking flake syntax..."
	nix flake check
	@echo "✅ Syntax check passed!"

# Clean build artifacts
clean:
	@echo "🧹 Cleaning build artifacts..."
	rm -rf result result-*
	@echo "✅ Cleaned!"

# Install Nix (if not already installed)
/nix:
	@echo "📥 Installing Nix..."
	curl -L https://nixos.org/nix/install | sh

# Install nix-darwin (if not already installed)
/run/current-system/sw/bin/darwin-rebuild: /nix
	@echo "📥 Installing nix-darwin..."
	/nix/var/nix/profiles/default/bin/nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
	yes | ./result/bin/darwin-installer

# Install Homebrew (if not already installed)
/opt/homebrew/bin/brew:
	@echo "📥 Installing Homebrew..."
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh -o /tmp/brew-install.sh
	NONINTERACTIVE=1 bash /tmp/brew-install.sh

# Bootstrap: Install everything needed for first-time setup
bootstrap: /nix /run/current-system/sw/bin/darwin-rebuild /opt/homebrew/bin/brew
	@echo "✅ Bootstrap complete! Run 'make build' to test your configuration."
