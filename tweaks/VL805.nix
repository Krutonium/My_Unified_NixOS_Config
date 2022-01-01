{ config, ...}:
{
    # My PCIe Expansion card which features a VL805 crashes if native iommu groups are used.
    # Software IOMMU fixes this.
    boot.kernelParams = [ "iommu=soft" ];
}