{ pkgs, config, ... }:
{
  nix.buildMachines = [
    {
      #uWebServer
      hostName = "192.168.0.10";
      system = "x86_64-linux";
      maxJobs = 8;
      speedFactor = 2;
      supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
      mandatoryFeatures = [];
    }
    {
      #uGamingPC
      hostName = "192.168.0.40";
      system = "x86_64-linux";
      maxJobs = 8;
      speedFactor = 2;
      supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
      mandatoryFeatures = [];
    }
    {
      #uMsiLaptop
      hostName = "192.168.0.20";
      system = "x86_64-linux";
      maxJobs = 0;
      speedFactor = 1;
      supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
      mandatoryFeatures = [];
    }
  ];
  nix.distributedBuilds = true;
  nix.settings.cores = 0;
}
