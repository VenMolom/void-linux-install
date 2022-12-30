#! /bin/sh

xbps-install -Sy zsh
useradd -m -G wheel,input,video,audio,shutdown -s /bin/zsh molom
passwd molom
