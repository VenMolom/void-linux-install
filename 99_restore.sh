# Follow instruction from `00-install.sh` till `#mount partitions` (DON'T CREATE @root AND @home SUBVOLUMES).
# At this point have both backup and target partition mounted (raw, no subvolumes).

# Copy newest snapshot from backup to @snapshots subvolume
btrfs send /mnt/backup/home | btrfs receive /mnt/target/@snapshots
btrfs send /mnt/backup/root | btrfs receive /mnt/target/@snapshots

# Reinstatiate subvolumes from snapshots
btrfs sub snap /mnt/target/@snapshots/home /mnt/target/@home
btrfs sub snap /mnt/target/@snapshots/root /mnt/target/@root

# Continue with install in sane way (don't create dirs and install stuff) into CHROOT to change disk UUIDs and update grub.
