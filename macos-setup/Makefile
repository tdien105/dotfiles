.POSIX:
.PHONY: default build update

default: build

/nix:
	curl -L https://nixos.org/nix/install | sh
	# TODO https://github.com/LnL7/nix-darwin/issues/149
	sudo rm /etc/nix/nix.conf

/run/current-system/sw/bin/darwin-rebuild:
	/nix/var/nix/profiles/default/bin/nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
	yes | ./result/bin/darwin-installer

/opt/homebrew/bin/brew:
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh -o /tmp/brew-install.sh
	NONINTERACTIVE=1 bash /tmp/brew-install.sh

build: /nix /run/current-system/sw/bin/darwin-rebuild /opt/homebrew/bin/brew
	/run/current-system/sw/bin/nix --experimental-features 'nix-command flakes' build ./\#darwinConfigurations.$(shell hostname -s).system
	./result/sw/bin/darwin-rebuild switch --flake .

update:
	nix flake update
