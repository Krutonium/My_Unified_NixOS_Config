#!/usr/bin/env bash
git pull
nix run .#deploy-rs
