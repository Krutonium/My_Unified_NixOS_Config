{ config }:
{
  boot.kernelParams = [ "radeon.cik_support=0" "radeon.si_support=0" "amdgpu.cik_support=1" "amdgpu.si_support=1" "amdgpu.dc=1" ];  
}
