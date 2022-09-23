{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    pkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-22.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    betterfancontroller.url = "github:Krutonium/BetterFanController";
    betterfancontroller.inputs.nixpkgs.follows = "nixpkgs";
    deploy-cs.url = "github:Krutonium/deploy-cs";
    deploy-cs.inputs.nixpkgs.follows = "nixpkgs";
    twitch2youtube.url = "git+https://gitea.krutonium.ca/Krutonium/Twitch2YouTube.git";
    twitch2youtube.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixpkgs, pkgs-unstable, nixos-hardware, nur, home-manager, betterfancontroller, deploy-cs, twitch2youtube }: {
    ################################################################################
    # uGamingPC
    ################################################################################

    nixosConfigurations.uGamingPC = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./common.nix
        ./devices/uGamingPC.nix
        ./devices/hardware-configurations/uGamingPC.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = false;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {
            pkgs-unstable = import pkgs-unstable {
              system = "x86_64-linux";
              config.allowUnfree = true;
            };
          };
        }
        ({ pkgs, ... }: {
          nixpkgs.overlays = [
            (self: super: {
              deploy-cs = deploy-cs.defaultPackage.x86_64-linux;
              BetterFanController = betterfancontroller.defaultPackage.x86_64-linux;
            })
          ];
        })
      ] ++ (with nixos-hardware.nixosModules; [
        common-pc
        common-pc-ssd
        common-cpu-amd
        common-gpu-amd
      ]);
      specialArgs = {
        pkgs-unstable = import pkgs-unstable {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
      };
    };

    ################################################################################
    # uWebServer
    ################################################################################

    nixosConfigurations.uWebServer = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./common.nix
        ./devices/uWebServer.nix
        ./devices/hardware-configurations/uWebServer.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = false;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {
            pkgs-unstable = import pkgs-unstable {
              system = "x86_64-linux";
              config.allowUnfree = true;
            };
          };
        }
        ({ pkgs, ... }: {
          nixpkgs.overlays = [
            (self: super: {
              deploy-cs = deploy-cs.defaultPackage.x86_64-linux;
              twitch2youtube = twitch2youtube.defaultPackage.x86_64-linux;
            })
          ];
        })
      ] ++ (with nixos-hardware.nixosModules; [
        common-pc
        common-pc-ssd
        common-cpu-intel
      ]);
      specialArgs = {
        pkgs-unstable = import pkgs-unstable {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
      };
    };

    ################################################################################
    # uMsiLaptop
    ################################################################################

    nixosConfigurations.uMsiLaptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./common.nix
        ./devices/uMsiLaptop.nix
        ./devices/hardware-configurations/uMsiLaptop.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = false;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {
            pkgs-unstable = import pkgs-unstable {
              system = "x86_64-linux";
              config.allowUnfree = true;
            };
          };
        }
        ({ pkgs, ... }: {
          nixpkgs.overlays = [
            (self: super: {
              deploy-cs = deploy-cs.defaultPackage.x86_64-linux;
            })
          ];
        })
      ] ++ (with nixos-hardware.nixosModules; [
        common-pc
        common-pc-ssd
        common-cpu-intel
      ]);
      specialArgs = {
        pkgs-unstable = import pkgs-unstable {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
      };
    };

    #####
    # Build an ISO with Gnome and Flakes and other custom stuff
    #####

    nixosConfigurations."isoImage" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      isoImage.squashfsCompression = "gzip -Xcompression-level 1";
      modules = [
        ./common.nix
        ./devices/uIsoDevice.nix
        "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-gnome.nix"
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = false;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {
            pkgs-unstable = import pkgs-unstable {
              system = "x86_64-linux";
              config.allowUnfree = true;
            };
          };
        }
        ({ pkgs, ... }: {
          nixpkgs.overlays = [
            (self: super: {
              deploy-cs = deploy-cs.defaultPackage.x86_64-linux;
            })
          ];
        })
      ];
      specialArgs = {
        pkgs-unstable = import pkgs-unstable {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
      };
    };
  };
}
