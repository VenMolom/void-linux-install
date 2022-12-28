#! /bin/sh

# format partitions:
# p1 - EFI
# p2 - SWAP
# p3 - Linux Filesystem

# mkfs.vfat -nBOOT -F32 /dev/nvme1n1p1
mkswap -L SWAP /dev/nvme1n1p2
mkfs.btrfs -L "Void Linux" /dev/nvme1n1p3

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
cp /etc/resolv.conf /mnt/etc/
BTRFS_OPTS=$BTRFS_OPTS PS1='(chroot) # ' chroot /mnt/ /bin/bash

# in chroot
echo Void-Desktop > /etc/hostname

passwd

UEFI_UUID=$(blkid -s UUID -o value /dev/nvme1n1p1)
SWAP_UUID=$(blkid -s UUID -o value /dev/nvme1n1p2)
ROOT_UUID=$(blkid -s UUID -o value /dev/nvme1n1p3)
cat <<EOF > /etc/fstab
UUID=$ROOT_UUID / btrfs $BTRFS_OPTS,subvol=@root 0 1
UUID=$UEFI_UUID /boot/efi vfat defaults,noatime 0 2
UUID=$ROOT_UUID /home btrfs $BTRFS_OPTS,subvol=@home 0 2
UUID=$ROOT_UUID /.snapshots btrfs $BTRFS_OPTS,subvol=@snapshots 0 2
UUID=$SWAP_UUID swap swap rw,noatime,discard 0 0
tmpfs /tmp tmpfs defaults,nosuid,nodev 0 0
EOF

echo hostonly=yes >> /etc/dracut.conf
xbps-install -Suy void-repo-nonfree
xbps-install -uy linux-firmware linux-firmware-network linux-firmware-amd
xbps-install -y grub-x86_64-efi
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id="Void Linux"


# configure locales and runit
sed -i 's/#HARDWARECLOCK=\".*\"/HARDWARECLOCK=\"localtime\"/' /etc/rc.conf
sed -i 's/#TIMEZONE=\".*\"/TIMEZONE=\"Europe/Warsaw\"/' /etc/rc.conf
sed -i 's/#KEYMAP=\".*\"/KEYMAP=\"pl\"/' /etc/rc.conf

ln -sf /usr/share/zoneinfo/Europe/Warsaw /etc/localtime

sed -i 's/#en_GB.UTF-8 UTF-8/en_GB.UTF-8 UTF-8/' /etc/default/libc-locales
sed -i 's/LANG=en_US\.UTF-8/LANG=en_GB\.UTF-8/' /etc/locale.conf
xbps-reconfigure -f glibc-locales

# logging
xbps=install -Syu socklog-void
ln -s /etc/sv/socklog-unix /var/service/
ln -s /etc/sv/nanologd /var/service/

# make shutdown group
groupadd shutdown
chown root:shutdown /sbin/shutdown
chmod 750 /sbin/shutdown
chmod u+s /sbin/shutdown

visudo

xbps-reconfigure -fa
exit
shutdown -r now