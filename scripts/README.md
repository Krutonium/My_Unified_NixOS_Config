# /Scripts

This is a collection of scripts that I've found quite useful over time, written myself.

## link.sh and relink.sh

These scripts symlink ../ to /etc/nixos/ - This is less useful since I've switched to flakes.

## set_upstream.sh

This script sets up the repo so that when I `git push` it pushes to both my gitea and github repos.

## UpdateAllSystems.sh

This script will run colmena to update the flake and all the other systems.

## configure_channels.sh

Adds the channels to NixOS that I use. Or did, before I switched to flakes.

## Future Plans:

Integrate these into Nix so that they're added to the system as part of a Nix deployment.