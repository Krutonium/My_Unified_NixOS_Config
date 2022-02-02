#!/usr/bin/env bash
git pull
nix run .#deploy-rs .#uWebServer
nix run .#deploy-rs .#uGamingPC
nix run .#deploy-rs .#uMsiLaptop
