#! /bin/sh

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
echo 'add_drivers+=" nvidia nvidia-drm nvidia-modeset nvidia-uvm "' > /etc/dracut.conf.d/nvidia.conf

xbps-install -Suy void-repo-nonfree
xbps-install -Suy linux-firmware linux-firmware-network linux-firmware-amd
xbps-install -Suy nvidia nvidia-libs-32bit
xbps-install -Suy curl xtools git wget
xbps-install -Suy apparmor
xbps-install -Suy openntpd
xbps-install -Suy grub-x86_64-efi
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id="Void Linux"

# configure locales and runit
sed -i 's/#HARDWARECLOCK=\".*\"/HARDWARECLOCK=\"localtime\"/' /etc/rc.conf
sed -i 's/#TIMEZONE=\".*\"/TIMEZONE=\"Europe/Warsaw\"/' /etc/rc.conf
sed -i 's/#KEYMAP=\".*\"/KEYMAP=\"pl\"/' /etc/rc.conf

ln -sf /usr/share/zoneinfo/Europe/Warsaw /etc/localtime
ln -s /etc/sv/openntpd /var/service/

sed -i 's/#en_GB.UTF-8 UTF-8/en_GB.UTF-8 UTF-8/' /etc/default/libc-locales
sed -i 's/LANG=en_US\.UTF-8/LANG=en_GB\.UTF-8/' /etc/locale.conf
xbps-reconfigure -f glibc-locales

# logging
xbps-install -Syu socklog-void
ln -s /etc/sv/socklog-unix /var/service/
ln -s /etc/sv/nanologd /var/service/

# kernel commandline params for nvidia and apparmor
sed -i 's/#\?GRUB_CMDLINE_LINUX_DEFAULT=\"\(.*\)\"/GRUB_CMDLINE_LINUX_DEFAULT="\1 apparmor=1 security=apparmor nvidia-drm.modeset=1"/' /etc/default/grub

visudo

xbps-reconfigure -fa
exit

# now restart