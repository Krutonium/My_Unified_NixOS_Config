# Krutonium's NixOS Config

Hey, Welcome to the repo. Heres' what you need to know:

The architecture of this repo is pretty simple (but also not) and can change as needed. This document is not gospel.

## Architecture

When applying the system, everything starts in `flake.nix`. In here, each possible device is defined with as little as possible, configuring Home Manager if desired for that host, and further adding in packages and repos I desire, Namely some of my own projects like deploy-cs, the NUR, or nixos-unstable.

Each system references `common.nix` which has settings that each device should have at a system level - If it's reasonable, and I want them all to have it, it goes in common, things like the `bpy` command, which is a good replacement for `htop`.

From there, each one will reference it's `/devices/<device-name>.nix` file which sets up device specific configuration. For example, pulling in `/users/<username>/user.nix` which itself does futher configuration of home manager if desired, as well as installing the applications I want installed for that user. It also handles things like configuring my Gnome Desktop Environment.

Services live in `/services/` and one off packaging of things like themes and scripts go in `/packages/`, and these are both directly referenced by the `device-name.nix` file to configure devices as specifically as desired. For example, `/services/nginx.nix` is only referenced from `uWebServer.nix`.

Hardware definitions for each computer exist in `/devices/hardware-configurations/<device-name.nix>` and are considered *temporary at best*, by which I mean on subsequent re-installs of the OS, they may be completely replaced without notice. 

## Updating

I use my own update solution that lives on `uWebServer` called `deploy-cs` paired with a script in `packages/scripts.nix` that enables updating to be done via just typing `update` on uWebServer, and on any client device by typing the same when off LAN.

It will automatically update the flakelock file, commit, pull, and push the git repo, syncronizing it with the remote, since it can be edited from anywhere.
It will then check which hosts are online, download the relevant packages, connect over SSH, push the files to the system, and activate the configuration.

## Useful Commands:

`update` updates the local system, and all others if on LAN. Intended to be used on `uWebServer`  
`resetConfig` deletes the repo and then redownloads and configures it  
`pushConfig` pushes the current config to the repo
