{ config, ... }:
{
  # My PCIe Expansion card which features a VL805 crashes if native iommu groups are used.
  # Software IOMMU fixes this.

  boot.kernelParams = [ "iommu=soft" "udev.event-timeout=1" ];

  # Update: Just fucking disable it
  #boot.kernelModules = ["vfio-pci"];
  #boot.kernelParams = ["vfio-pci.ids=1106:3483"];
}
