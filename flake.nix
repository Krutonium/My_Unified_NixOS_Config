{
  inputs = {
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    betterfancontroller.url = "github:Krutonium/BetterFanController";
    betterfancontroller.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixpkgs, nixos-hardware, nixpkgs-unstable, home-manager, betterfancontroller }: {
    nixosConfigurations.uMsiLaptop = nixpkgs.lib.nioxosSystem {
      system = "x86_64-linux";
      modules = [
        ./common.nix
        ./devices/uMsiLaptop.nix
        ./devices/hardware-configurations/uMsiLaptop.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = false;
          home-manager.useUserPkgs = true;
        }
      ] ++ (with nixos-hardware.nixosModules; [
        common-pc
        common-pc-ssd
        common-cpu-intel
        common-gpu-intel
        common-gpu-nvidia
      ]);
    };
  };
}