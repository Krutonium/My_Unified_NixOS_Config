# Krutonium's NixOS Config

Hey, Welcome to the repo. Heres' what you need to know:

In order to use these configs, you need to add hardware-config to your channels (at least until I can figure out how to import that directly inside the nix file. Help is appreciated!)
```
sudo nix-channel --add https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
```
You will also need to copy `device.nix.default` and name it `device.nix`. Inside, you want to edit the import to be the specific config you want to use. Configs are in `/devices` for reference.

Other than that, everything is as much as possible done via imports, to make it all as modular as possible. 

Questions? Comments? Open an Issue or contact me on Telegram [@Krutonium](t.me/Krutonium)!

