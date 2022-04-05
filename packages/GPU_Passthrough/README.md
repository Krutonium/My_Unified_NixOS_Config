# The Adventures in GPU Passthrough

Alright so to begin with:

PC Specs:

- Gigbyte Aorus B450 (AMD) Pro Wifi
- RX 5600XT
- GTX 750 Ti
- 32GB RAM

When I initially ran the iommu script (found at iommu.sh), 
I found that the top slot where the GPU goes is in its own IOMMU Group!
Perfect!

Except that means my primary GPU has to go in the second slot. Oh well, not going to hurt anything
though you should make sure you swap in the UEFI which GPU to use at boot to slot 2, otherwise you'll
get no output until you finish booting into your OS.

After swapping them, I found the following:

```
IOMMU Group 13 	08:00.0 VGA compatible controller [0300]: NVIDIA Corporation GM107 [GeForce GTX 750 Ti] [10de:1380] (rev a2)
IOMMU Group 13 	08:00.1 Audio device [0403]: NVIDIA Corporation GM107 High Definition Audio Controller [GeForce 940MX] [10de:0fbc] (rev a1)
```
It was in it's own IOMMU Group! Hell yeah!

Alright, now that we have a GPU on it's own IOMMU, lets see about setting literally everything else up.

We need to do the following:

Create a VM
Give it the GPU.

First Step: Enable VFIO

This is done at the top of `enter_the_matrix.nix` by disabling `nouveau` and enabling `vfio-pci`
Then adding the PCI id's of our GPU to the `vfio-pci` driver at boot.

Second Step: Create your VM, and pass through all the devices you want it to have from the IOMMU Group.

Third Step: If the GPU is nVidia, `sudo EDITOR=nano virsh edit <vm-name>`
And then add the following into the file

```
...
<features>
	<hyperv>
		...
		<vendor_id state='on' value='whatever'/>
		...
	</hyperv>
	...
	<kvm>
	<hidden state='on'/>
	</kvm>
</features>
...
```

For example in my case:

```
  <features>
    <acpi/>
    <apic/>
    <hyperv>
      <relaxed state='on'/>
      <vapic state='on'/>
      <spinlocks state='on' retries='8191'/>
      <vendor_id state='on' value='Gigabyte'/>
    </hyperv>
    <kvm>
      <hidden state='on'/>
    </kvm>
    <vmport state='off'/>
  </features>
```

If you plan to use Looking Glass (Installed by default in the config) you also need to

```
<devices>
    ...
  <shmem name='looking-glass'>
    <model type='ivshmem-plain'/>
    <size unit='M'>32</size>
  </shmem>
</devices>
```
Where 32 is 
```
width x height x 4 x 2 = total bytes
total bytes / 1024 / 1024 = total mebibytes + 10
```
You will also want to devices:

```
    <sound model='ich9'>
      <codec type='micro'/>
      <audio id='1'/>
    </sound>
    <audio id='1' type='pulseaudio' serverName='/run/user/1000/pulse/native'/>
```
This assumes that you are user 1000. It enables Sound to PulseAudio which is secretly Pipewire.

And finally, you'll want to find <video> and set the `<model type=` to `none`.

You may also need to chmod /dev/shm/looking-glass to 666

```