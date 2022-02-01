#!/usr/bin/env bash

# This script should restart as root if it's not already
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root" 1>&2
    exec sudo "$0" "$@"
fi

mv /etc/nixos/ /etc/nixos.bak/ || true
ln -s $(pwd) /etc/nixos
# nixos-generate-config
