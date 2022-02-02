{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    deploy-rs.url = "github:serokell/deploy-rs";
  };

  outputs = { self, nixpkgs, home-manager, nixpkgs-unstable, nixos-hardware, deploy-rs }: {
    checks = builtins.mapAttrs
      (system: deployLib: deployLib.deployChecks self.deploy)
      deploy-rs.lib;

    inherit (deploy-rs) apps;

    deploy.nodes.uMsiLaptop = {
      hostname = "uMsiLaptop";
      profiles.system = {
        sshUser = "root";
        fastConnection = true; # if local network is faster than WAN
        path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.uMsiLaptop;
      };
    };

    deploy.nodes.uGamingPC = {
      hostname = "uGamingPC";
      profiles.system = {
        sshUser = "root";
        fastConnection = true;
        path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.uGamingPC;
      };
    };

    deploy.nodes.uWebServer = {
      hostname = "uWebServer";
      profiles.system = {
        sshUser = "root";
        fastConnection = true;
        path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.uWebServer;
      };
    };



    nixosConfigurations.uGamingPC = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./common.nix
        ./hardware-configurations/uGamingPC.nix
        ./devices/uGamingPC.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = false;
          home-manager.useUserPackages = true;
        }
      ] ++ (with nixos-hardware.nixosModules; [
        common-pc
        common-pc-ssd
        common-cpu-amd
        common-gpu-amd
      ]);
    };
    nixosConfigurations.uMsiLaptop = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      specialArgs = {
        pkgs-unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      };
      modules = [
        ./common.nix
        ./hardware-configurations/uMsiLaptop.nix
        ./devices/uMsiLaptop.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = false;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = specialArgs;
        }
      ] ++ (with nixos-hardware.nixosModules; [
        common-pc
        common-pc-ssd
        common-cpu-intel
      ]);
    };
    nixosConfigurations.uWebServer = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      specialArgs = {
        pkgs-unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      };
      modules = [
        ./common.nix
        ./hardware-configurations/uWebServer.nix
        ./devices/uWebServer.nix
      ];
    };
  };
}
