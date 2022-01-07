#!/usr/bin/env bash
sudo rm /etc/nixos
sudo ln -s $(pwd) /etc/nixos
sudo nixos-generate-config

