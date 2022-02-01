# Krutonium's NixOS Config

Hey, Welcome to the repo. Heres' what you need to know:

System Definitions go in /devices/
Hardware Definitions for those systems go in /hardware-configurations/ and should named after the device
Define the systems to manage in flake.nix, you can use the existing definitions as guidance
And finally, to update all the things:

`nix run .#deploy-rs`

Go forth and Enjoy!

## Useful Scripts:

On a new install where you're replacing either a stock config or your own config with mine, run `link.sh`. If you've moved the repo and want it to update the repo location, run `relink.sh` instead.

For me personally I also have `set_upstream.sh` which adds my personal gitea and github as remotes that will be pushed to at the same time.

Questions? Comments? Open an Issue or contact me on Telegram [@Krutonium](t.me/Krutonium)!

