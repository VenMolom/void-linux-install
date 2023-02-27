#! /bin/sh

# prepare
sudo xbps-install -Syu gcc cmake rsync unzip yarn nodejs xdg-user-dirs xdg-desktop-portal xdg-desktop-portal-wlr xdg-desktop-portal-gtk xdg-utils libva w3m ffmpegthumbnailer atool ImageMagick librsvg librsvg-utils meson wayland-protocols scdoc wayland-devel libxkbcommon-devel cairo-devel libgomp-devel psmisc

# browser and terminal
sudo xbps-install -Syu firefox wezterm wezterm-terminfo

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
mkdir ~/.zfunc
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/softmoth/zsh-vim-mode.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-vim-mode
git clone https://github.com/kutsan/zsh-system-clipboard ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-system-clipboard
git clone https://github.com/joshskidmore/zsh-fzf-history-search ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-fzf-history-search

# rust and completions
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup completions zsh > ~/.zfunc/_rustup
rustup completions zsh cargo > ~/.zfunc/_cargo

# launcher and console apps
sudo xbps-install -Syu wofi btop ranger lazygit exa

# nvim
cargo install bob-nvim
bob install stable

# nvim tools
sudo xbps-install -Syu fd bat ripgrep delta

# powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# fzf
xbps-install -Syu fzf

# flatpak and discord
sudo xbps-install -Syu flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak install flathub com.discordapp.Discord

# music
sudo xbps-install -Syu pkg-config alsa-lib-devel libssh-devel libssh2-devel dbus-devel libxcb libxcb-devel playerctl
cargo install spotify_player --no-default-features --features='pulseaudio-backend streaming lyric-finder media-control image'

# video
sudo xbps-install -Suy mpv mpv-mpris

# day and night light
sudo xbps-install -Syu gammastep

# mail client
sudo xbps-install -Syu thunderbird thunderbird-i18n-en-GB

# proton mail bridge
sudo xbps-install -Syu pass libsecret libsecret-devel
# install from void-packages

# vpn client
sudo xbps-install -Suy protonvpn-cli

# top bar
sudo xbps-install -Suy waybar
cargo install sworkstyle

# top bar utils
sudo xbps-install -Syu libgirepository libgirepository-devel python3-gobject
