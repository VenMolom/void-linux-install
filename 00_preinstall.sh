#! /bin/sh

# format partitions:
# p1 - EFI
# p2 - SWAP
# p3 - Linux Filesystem

mkfs.vfat -nBOOT -F32 /dev/nvme1n1p1
mkswap -L SWAP /dev/nvme1n1p2
mkfs.btrfs -f -L "Void Linux" /dev/nvme1n1p3

# create subvolumes
BTRFS_OPTS="rw,noatime,ssd,compress=zstd,space_cache=v2,commit=120"
mount -o $BTRFS_OPTS /dev/nvme1n1p3 /mnt
btrfs subvolume create /mnt/@root
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@snapshots
umount /mnt

# mount partitions
mount -o $BTRFS_OPTS,subvol=@root /dev/nvme1n1p3 /mnt
mkdir -p /mnt/home
mount -o $BTRFS_OPTS,subvol=@home /dev/nvme1n1p3 /mnt/home
mkdir -p /mnt/.snapshots
mount -o $BTRFS_OPTS,subvol=@snapshots /dev/nvme1n1p3 /mnt/.snapshots

mkdir -p /mnt/boot/efi/
mount -o rw,noatime /dev/nvme1n1p1 /mnt/boot/efi

# create subvolums for files that we don't want to snapshot
mkdir -p /mnt/var/cache
btrfs subvolume create /mnt/var/cache/xbps
btrfs subvolume create /mnt/var/tmp
btrfs subvolume create /mnt/srv

# install system
REPO=https://repo-de.voidlinux.org/current
ARCH=x86_64

mkdir -p /mnt/var/db/xbps/keys
cp /var/db/xbps/keys/* /mnt/var/db/xbps/keys/

XBPS_ARCH=$ARCH xbps-install -Sy -r /mnt -R "$REPO" base-system btrfs-progs

# chroot
for dir in dev proc sys run; do mount --rbind /$dir /mnt/$dir; mount --make-rslave /mnt/$dir; done
cp -r /void-linux-install /mnt/usr/
cp /etc/resolv.conf /mnt/etc/
BTRFS_OPTS=$BTRFS_OPTS PS1='(chroot) # ' chroot /mnt/ /bin/bash

# in chroot execute 01_install.sh
