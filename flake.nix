{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { self, nixpkgs, home-manager, nixpkgs-unstable, nixos-hardware }: {

    # colmena stuff

    colmena = {
      meta.nixpkgs = import nixpkgs { system = "x86_64-linux"; }; # default system
      meta.nodeNixpkgs = {
        #someMachine = import nixpkgs { system = arm or something };
      };

      defaults = { pkgs, ... }: {
        # default stuff shared for all nodes IIRC
        imports = [
        ];
      };

      # nodes
      uMsiLaptop = { name, nodes, pkgs, ... }: {
        deployment = {
          targetHost = "uMsiLaptop"; # well that could just be the name…
          tags = [ "workstations" ]; # this is nice to separate deployment groups
        };

        imports = [
          {
            _module.args = {
              pkgs-unstable = import nixpkgs-unstable {
                system = "x86_64-linux";
                config.allowUnfree = true;
              };
            };
          }
          ./common.nix
          ./hardware-configurations/uMsiLaptop.nix
          ./devices/uMsiLaptop.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = false;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              pkgs-unstable = import nixpkgs-unstable {
                system = "x86_64-linux";
                config.allowUnfree = true;
              };
            };
          }
        ] ++ (with nixos-hardware.nixosModules; [
          common-pc
          common-pc-ssd
          common-cpu-intel
        ]
        );
      };
      # uGamingPC
      uGamingPC = { name, nodes, pkgs, ... }: {
        deployment = {
          targetHost = "uGamingPC"; # well that could just be the name…
          tags = [ "workstations" ]; # this is nice to separate deployment groups
        };
        imports = [
          {
            _module.args = {
              pkgs-unstable = import nixpkgs-unstable {
                system = "x86_64-linux";
                config.allowUnfree = true;
              };
            };
          }
          ./common.nix
          ./hardware-configurations/uGamingPC.nix
          ./devices/uGamingPC.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = false;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              pkgs-unstable = import nixpkgs-unstable {
                system = "x86_64-linux";
                config.allowUnfree = true;
              };
            };
          }
        ] ++ (with nixos-hardware.nixosModules; [
          common-pc
          common-pc-ssd
          common-cpu-amd
          common-gpu-amd
        ]
        );
      };
      # uWebServer
      uWebServer = { name, nodes, pkgs, ... }: {
        deployment = {
          targetHost = "uWebServer"; # well that could just be the name…
          tags = [ "workstations" ]; # this is nice to separate deployment groups
        };
        imports = [
          {
            _module.args = {
              pkgs-unstable = import nixpkgs-unstable {
                system = "x86_64-linux";
                config.allowUnfree = true;
              };
            };
          }
          ./common.nix
          ./hardware-configurations/uWebServer.nix
          ./devices/uWebServer.nix
        ] ++ (with nixos-hardware.nixosModules; [
          common-pc
          common-cpu-intel
        ]);
      };
    };
  };
}
