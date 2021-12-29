{ config, pkgs, ...}:

# So a bit of a README:
# Before use, you need to create the following files:

# ./hostname

# ./hostname should contain the hostname for your system.
# Very importantly, it is used for selecting the system that will be generated from this config
# The options are:
# uWebServer
# GamingPC
# LaptopPC
#
# uWebServer is configured for hosting various services that I use
# GamingPC is configured as my Gaming PC, if that wasn't obvious
# LaptopPC is configured as my Laptop PC, It has Optimus from before it was good

# You also need to create ./kernel
# ./kernel should state what kernel we want to use.

# NEITHER OF THOSE FILES SHOULD BE CHECKED IN.


let
    # Variables!
    hostname = readFile("./hostname");
    kernel = pkgs.linuxPackages_zen;
in
{
    # First, everything that applies to all machines:
    imports =
    [
        # Import other files that are used by all associated computers
        ./hardware-configuration.nix
    ];

    # Set our Kernel
    boot.kernelPackages = kernel;

    # Misc Settings - Optimize for Size, Compatible with Windows time, Enable unfree packages.
    nix.autoOptimiseStore = true;
    nix.gc.automatic = true;
    nix.gc.options = "--delete-older-than 3d";
    time.hardwareClockInLocalTime = true;
    nixpkgs.config.allowUnfree = true;

    # We always want 8 GB of Swap.
    swapDevices = [{
        devices = "/swap";
        size = 1024 * 8;
    }];

    # ZFS is a pain in the ass with it's own mounting when paired with the hardware config.
    # Disabling the service is the easiest solution.
    systemd.services = {
        zfs-mount = {
             enabled = false;
             restartIfChanged = false;
        };
    };

    time.timeZone = "America/Toronto";

    # This disables DHCP on interfaces that shouldn't have it.
    networking.useDHCP = false;

    # This is perfectly fine to do apparently, so I'm leaving it out of the individual bits.
    # Add and remove Ethernet Interfaces as needed.
    networking.interfaces.eno1.useDHCP = true;    #GamingPC
    networking.interfaces.enp0s25.useDHCP = true; #uWebServer
    networking.interfaces.enp3s0.useDHCP = true;  #Laptop
    networking.hostName = hostname;
    networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];
    networking.firewall.enable = true;
    i18n.defaultLocale = "en_US.UTF-8";
    console = {
        keyMap = "us";
    };

    # Let me tell you a story about a bad switch that dropped me to an
    # emergency console instead of letting me see what went wrong...
    # https://github.com/NixOS/nixpkgs/issues/147783
    systemd.enableEmergencyMode = false;

    #Install the Base Packages that all systems should have.
    environment.systemPackages [
        pkgs.nano #Editor
        pkgs.git
    ];
    services.openssh.enable = true;

    # And now for the per hostname stuff.
    if hostname == "Gaming-PC" then (
        imports =
        [
            ./gaming-pc.nix
        ];
    )
    if hostname == "uWebServer" then (
        imports =
        [
            ./uwebserver.nix
        ];
    )


    system.stateVersion = "21.11";
}