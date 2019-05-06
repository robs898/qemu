VGAPT_FIRMWARE_BIN=/usr/share/edk2.git/ovmf-x64/OVMF_CODE-pure-efi.fd
VGAPT_FIRMWARE_VARS=/usr/share/edk2.git/ovmf-x64/OVMF_VARS-pure-efi.fd
VGAPT_FIRMWARE_VARS_TMP=/tmp/OVMF_VARS.fd.tmp
QEMU=/bin/qemu-system-x86_64
DISK=/home/rob/windows/disk.img

cp -f $VGAPT_FIRMWARE_VARS $VGAPT_FIRMWARE_VARS_TMP &&
$QEMU \
  -drive if=pflash,format=raw,readonly,file=$VGAPT_FIRMWARE_BIN \
  -drive if=pflash,format=raw,file=$VGAPT_FIRMWARE_VARS_TMP \
  -enable-kvm \
  -machine q35,accel=kvm,mem-merge=off,kernel-irqchip=on \
  -cpu host,kvm=off,hv_vendor_id=vgaptrocks,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time \
  -smp 4,cores=4,sockets=1,threads=1 \
  -m 4096 \
  -rtc base=localtime \
  -serial none \
  -parallel none \
  -usb \
  -device vfio-pci,host='01:00.0',multifunction=on \
  -device virtio-scsi-pci,id=scsi \
  -device ich9-intel-hda,id=sound0,bus=pcie.0,addr=0x1b \
  -device hda-duplex,id=sound0-codec0,bus=sound0.0,cad=0 \
  -drive file=$DISK,id=disk,format=qcow2,if=none,cache=writeback -device scsi-hd,drive=disk \
  -net nic,model=virtio \
  -net user
