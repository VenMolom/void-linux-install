#! /bin/sh

ln -s /etc/sv/dhcpcd /var/service/
xbps-install -S

xbps-install -Syu ufw ufw-extras
ln -s /etc/sv/ufw /var/service/
ufw enable
ufw default deny

xbps-install -Syu apparmor
echo 'kernel_cmdline="apparmor=1 security=apparmor"' >> /etc/dracut.conf
