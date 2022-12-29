#! /bin/sh

# graphics drivers
xbps-install -Suy mesa-dri vulkan-loader mesa-vulkan-radeon amdvlk mesa-vaapi mesa-vdpau

# fonts
xbps-install -Suy google-fonts-ttf 

# seatd
xbps-install -Suy seatd
usermod -aG _seatd molom
ln -s /etc/sv/seatd /var/service/

# sway
xbps-install -Suy sway swaylock swayidle

# login manager
xbps-install -Suy tuigreet
sed -i 's/vt = .*/vt = 1/' /etc/greetd/config.toml
sed -i 's/command = \".*\"/command = \"tuigreet -c sway --user-menu -t -r --power-shutdown \'sudo shutdown -h now\' --power-reboot \'sudo shutdown -r now\'\"/' /etc/greetd/config.toml
usermod -aG shutdown _greeter
touch /etc/sv/greetd/down
ln -s /etc/sv/greetd /var/service/
