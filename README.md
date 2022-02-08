# Krutonium's NixOS Config

Hey, Welcome to the repo. Heres' what you need to know:

System Definitions go in /devices/
Hardware Definitions for those systems go in /hardware-configurations/ and should named after the device
Define the systems to manage in flake.nix, you can use the existing definitions as guidance
And finally, to update all the things:

`nix flake update --commit-lock-file` to update the flake inputs and commit that change to the repo.
`colmena apply switch` to apply the config

Go forth and Enjoy!

## Useful Scripts:

On a new install where you're replacing either a stock config or your own config with mine, run `link.sh`. If you've moved the repo and want it to update the repo location, run `relink.sh` instead.

For me personally I also have `set_upstream.sh` which adds my personal gitea and github as remotes that will be pushed to at the same time.

Also `UpdateAllSystems.sh` will update all the things as well.

Questions? Comments? Open an Issue or contact me on Telegram [@Krutonium](t.me/Krutonium)!

## Example Output of `nix run .#deploy-rs`

```
🚀 ℹ️ [deploy] [INFO] Running checks for flake in .
warning: unknown flake output 'deploy'
🚀 ℹ️ [deploy] [INFO] Evaluating flake in .
🚀 ℹ️ [deploy] [INFO] The following profiles are going to be deployed:
[uGamingPC.system]
user = "root"
ssh_user = "root"
path = "/nix/store/gm18qbk6c3kzj8k7hhix85gkxxrsspxc-activatable-nixos-system-uGamingPC-21.11.20220116.8a70a68"
hostname = "uGamingPC"
ssh_opts = []
[uWebServer.system]
user = "root"
ssh_user = "root"
path = "/nix/store/ipbsraji0nvcv5wg7abv82i2hl9whwar-activatable-nixos-system-uWebServer-21.11.20220116.8a70a68"
hostname = "uWebServer"
ssh_opts = []
[uMsiLaptop.system]
user = "root"
ssh_user = "root"
path = "/nix/store/w6pacicd260mvh3m6abp2hqaq0mpjh53-activatable-nixos-system-uMsiLaptop-21.11.20220116.8a70a68"
hostname = "uMsiLaptop"
ssh_opts = []

🚀 ℹ️ [deploy] [INFO] Building profile `system` for node `uGamingPC`
🚀 ℹ️ [deploy] [INFO] Copying profile `system` to node `uGamingPC`
🚀 ℹ️ [deploy] [INFO] Building profile `system` for node `uWebServer`
🚀 ℹ️ [deploy] [INFO] Copying profile `system` to node `uWebServer`
🚀 ℹ️ [deploy] [INFO] Building profile `system` for node `uMsiLaptop`
🚀 ℹ️ [deploy] [INFO] Copying profile `system` to node `uMsiLaptop`
🚀 ℹ️ [deploy] [INFO] Activating profile `system` for node `uGamingPC`
🚀 ℹ️ [deploy] [INFO] Creating activation waiter
⭐ ℹ️ [activate] [INFO] Activating profile
👀 ℹ️ [wait] [INFO] Waiting for confirmation event...
updating GRUB 2 menu...
Warning: os-prober will be executed to detect other bootable partitions.
Its output will be used to detect bootable binaries on them and create new boot entries.
lsblk: /dev/mapper/no*[0-9]: not a block device
lsblk: /dev/mapper/raid*[0-9]: not a block device
lsblk: /dev/mapper/disks*[0-9]: not a block device
Found Windows Boot Manager on /dev/sde1@/EFI/Microsoft/Boot/bootmgfw.efi
activating the configuration...
setting up /etc...
reloading user units for root...
reloading user units for krutonium...
setting up tmpfiles
the following new units were started: drwhowifi.service
⭐ ℹ️ [activate] [INFO] Activation succeeded!
⭐ ℹ️ [activate] [INFO] Magic rollback is enabled, setting up confirmation hook...
👀 ℹ️ [wait] [INFO] Found canary file, done waiting!
⭐ ℹ️ [activate] [INFO] Waiting for confirmation event...
🚀 ℹ️ [deploy] [INFO] Success activating, attempting to confirm activation
🚀 ℹ️ [deploy] [INFO] Deployment confirmed.
🚀 ℹ️ [deploy] [INFO] Activating profile `system` for node `uWebServer`
🚀 ℹ️ [deploy] [INFO] Creating activation waiter
⭐ ℹ️ [activate] [INFO] Activating profile
👀 ℹ️ [wait] [INFO] Waiting for confirmation event...
updating GRUB 2 menu...
Warning: os-prober will be executed to detect other bootable partitions.
Its output will be used to detect bootable binaries on them and create new boot entries.
lsblk: /dev/mapper/no*[0-9]: not a block device
lsblk: /dev/mapper/raid*[0-9]: not a block device
lsblk: /dev/mapper/disks*[0-9]: not a block device
stopping the following units: minecraft-server.service, satisfactory.service
NOT restarting the following changed units: systemd-fsck@dev-disk-by\x2duuid-464eda6e\x2deffe\x2d4950\x2daffc\x2d918dd1dbfe2d.service, systemd-fsck@dev-disk-by\x2duuid-D63A\x2dDFE8.service
activating the configuration...
removing group ‘minecraft’
removing user ‘minecraft’
setting up /etc...
reloading user units for root...
setting up tmpfiles
reloading the following units: dbus.service, firewall.service
⭐ ℹ️ [activate] [INFO] Activation succeeded!
⭐ ℹ️ [activate] [INFO] Magic rollback is enabled, setting up confirmation hook...
👀 ℹ️ [wait] [INFO] Found canary file, done waiting!
⭐ ℹ️ [activate] [INFO] Waiting for confirmation event...
🚀 ℹ️ [deploy] [INFO] Success activating, attempting to confirm activation
🚀 ℹ️ [deploy] [INFO] Deployment confirmed.
🚀 ℹ️ [deploy] [INFO] Activating profile `system` for node `uMsiLaptop`
🚀 ℹ️ [deploy] [INFO] Creating activation waiter
👀 ℹ️ [wait] [INFO] Waiting for confirmation event...
⭐ ℹ️ [activate] [INFO] Activating profile
activating the configuration...
setting up /etc...
reloading user units for root...
reloading user units for krutonium...
setting up tmpfiles
👀 ℹ️ [wait] [INFO] Found canary file, done waiting!
⭐ ℹ️ [activate] [INFO] Activation succeeded!
⭐ ℹ️ [activate] [INFO] Magic rollback is enabled, setting up confirmation hook...
⭐ ℹ️ [activate] [INFO] Waiting for confirmation event...
🚀 ℹ️ [deploy] [INFO] Success activating, attempting to confirm activation
🚀 ℹ️ [deploy] [INFO] Deployment confirmed.
```
