# qemu

guide: https://github.com/saveriomiroddi/vga-passthrough/blob/master/3_BASIC_SETUP.md

## ovmf

on musl void you can't build with gcc from git. So use `rpmextract` on:

https://www.kraxel.org/repos/jenkins/edk2/

And move the fd files to `/usr/share`

## install

40GB qcow

attach the windows iso and drivers. install the scsi driver and net driver.

libvirt/virsh isn't required neither is virt-manager

## run

`sudo ./run.sh`

## help
https://wiki.archlinux.org/index.php/PCI_passthrough_via_OVMF#Prerequisites

increase disk size:

`qemu-img resize disk.qcow2 +5GB`
