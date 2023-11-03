#! /bin/sh

# prepare
sudo xbps-install -Syu gcc cmake rsync unzip xdg-user-dirs xdg-desktop-portal xdg-desktop-portal-gtk xdg-utils meson libxkbcommon-devel cairo-devel libgomp-devel psmisc polkit

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

# zoxide
sudo xbps-install -Syu zoxide

# prompt
sudo xbps-install -Syu starship

# rust and completions
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup completions zsh > ~/.zfunc/_rustup
rustup completions zsh cargo > ~/.zfunc/_cargo

# launcher and console apps
sudo xbps-install -Syu btop lazygit exa fd bat ripgrep delta lazygit

# helix editor
sudo xbps-install -Syu helix

# fzf
xbps-install -Syu fzf

# music
sudo xbps-install -Syu pkg-config alsa-lib-devel libssh-devel libssh2-devel dbus-devel libxcb libxcb-devel playerctl
cargo install spotify_player --no-default-features --features='pulseaudio-backend streaming lyric-finder media-control image notify daemon'

# video
sudo xbps-install -Suy mpv mpv-mpris

# day and night light
sudo xbps-install -Syu gammastep

# notifications manager
sudo xbps-install -Syu dunst

# mail client
sudo xbps-install -Syu thunderbird thunderbird-i18n-en-GB

# torrent client
sudo xbps-install -Syu qbittorrent

# pdf reader
sudo xbps-install -Syu zathura

# proton mail bridge
sudo xbps-install -Syu pass libsecret libsecret-devel

# install proton bridge from void-packages
# vpn client
sudo xbps-install -Suy protonvpn-cli

# TODO: discord