#!/usr/bin/env bash
sudo mv /etc/nixos/ /etc/nixos.bak/ || true
sudo ln -s $(pwd) /etc/nixos
sudo nixos-generate-config
sudo rm /auth
sudo ln -s $(pwd)/auth /auth
