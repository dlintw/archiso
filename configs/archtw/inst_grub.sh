#!/bin/bash
usage() {
  cat <<EOT
Usage: inst_grub.sh <usb_dev> <usb_mnt>
ex. mount /dev/sdb1 /mnt/sdb1
    inst_grub.sh /dev/sdb /mnt/sdb1
EOT
  exit 1
}
[ $# -ne 2 ] && usage
[ $EUID != 0 ] && echo "Err: should be root" && exit 1
usb_dev=$1
usb_mnt=$2

set -e -x

# install grub
if [ ! -d $usb_mnt/boot/grub ] ; then
  grub-install  --debug --boot-directory=$usb_mnt/boot $usb_dev
  for f in $usb_mnt/boot/grub/locale/* ; do
    case $(basename $f) in
      zh_TW.mo): ;;
      *) rm -f $f;;
    esac
  done
fi

cat<<EOT > $usb_mnt/boot/grub/grub.sample.cfg
# path to the partition holding ISO images (using UUID)
probe -u \$root --set=rootuuid
set imgdevpath="/dev/disk/by-uuid/\$rootuuid"
menuentry 'archiso i686 ram' {
  linux /arch/boot/i686/vmlinuz archisobasedir=arch archisolabel=ARCH_TW \
    copytoram copytoram_size=373M cow_spacesize=50% cow_label=ARCH_COW
  initrd /arch/boot/intel_ucode.img /arch/boot/i686/archiso.img
}
EOT

# copy files
mkdir -p $usb_mnt/arch
cp -a work/iso/arch $usb_mnt
rm -rf $usb_mnt/arch/boot/syslinux
rm -rf $usb_mnt/arch/boot/memtest*

echo "merge $mnt_usb/boot/grub/grub.sample.cfg with grub.cfg manually"

# vim:et sw=2 ts=2 ai nocp sta

