#!/usr/bin/env bash
# Restart using sudo if not running as root
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root" 1>&2
    exec sudo "$0" "$@"
fi

# Configure channels
echo "Configuring channels..."
nix-channel --add https://nixos.org/channels/nixos-21.11 nixos
nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
nix-channel --add https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
nix-channel --update
echo "Done"

