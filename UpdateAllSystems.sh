#!/usr/bin/env bash
git pull
nix flake update --commit-lock-file
colmena apply switch --no-substitutes
