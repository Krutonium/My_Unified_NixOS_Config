#!/usr/bin/env bash
cd ../
git pull
nix flake update --commit-lock-file
colmena apply switch --no-substitutes
