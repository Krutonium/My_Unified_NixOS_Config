#!/usr/bin/env fish
cd ../
git pull
nix flake update --commit-lock-file
colmena apply switch --no-substitutes --on (hostname)
