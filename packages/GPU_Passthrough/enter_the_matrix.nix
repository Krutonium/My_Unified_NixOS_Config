{ config, pkgs, ...}:
let
  # I'm going to put all the configurables in here
  # This is the device ID's of my GTX 750 Ti with it's audio device as well.
  toPassToVM_kernelcmd = [ "vfio-pci.ids=10de:1380,10de:0fbc" ];
in
{
    #Disable the nouveau driver
    boot.blacklistedKernelModules = ["nouveau"];
    # If you're on Intel, you need
    # boot.kernelParams = ["intel_iommu=on"];
    # If you're on AMD, you don't need anything, it will just work.

    boot.kernelModules = ["vfio-pci"];
    # Add our nVidia GPU to passthrough
    boot.kernelParams = toPassToVM_kernelcmd;


}