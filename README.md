# Krutonium's NixOS Config

Hey, Welcome to the repo. Heres' what you need to know:

System Definitions go in /devices/
Hardware Definitions for those systems go in /hardware-configurations/ and should named after the device
Define the systems to manage in flake.nix, you can use the existing definitions as guidance
And finally, to update all the things:

`nix flake update --commit-lock-file` to update the flake inputs and commit that change to the repo.
`colmena apply switch` to apply the config

Go forth and Enjoy!

## Useful Commands:

`update` updates the local system
`updateAll` updates all computers on the LAN
`resetConfig` deletes the repo and then redownloads and configures it
`pushConfig` pushes the current config to the repo
`rebootEverything` reboots all computers on the LAN, useful after big updates
`rebootCancel` cancels reboots on all computers on the LAN.


Questions? Comments? Open an Issue or contact me on Telegram [@Krutonium](t.me/Krutonium)!
