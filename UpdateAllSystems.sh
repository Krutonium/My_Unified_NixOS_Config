#!/usr/bin/env bash
echo Deploying to WebServer
nixos-rebuild --flake .#uWebServer --target-host root@uWebServer switch
echo Deploying to GamingPC
nixos-rebuild --flake .#uGamingPC --target-host root@uGamingPC switch
echo Deploying to MsiLaptop
nixos-rebuild --flake .#uMsiLaptop --target-host root@uMsiLaptop switch

echo Complete
