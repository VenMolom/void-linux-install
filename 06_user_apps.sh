#! /bin/sh

# prepare
sudo xbps-install -Syu gcc vim cmake rsync unzip xdg-user-dirs xdg-desktop-portal xdg-desktop-portal-gtk xdg-utils meson libxkbcommon-devel cairo-devel libgomp-devel psmisc polkit xsel

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

# music
sudo xbps-install -Syu pkg-config alsa-lib-devel libssh-devel libssh2-devel dbus-devel libxcb libxcb-devel playerctl
cargo install spotify_player --no-default-features --features='pulseaudio-backend streaming lyric-finder media-control image notify daemon'

PACKAGES=""

# prompt
PACKAGES="$PACKAGES starship"

# console apps
PACKAGES="$PACKAGES btop lazygit exa fd bat ripgrep delta lazygit zoxide fzf"

# helix editor
PACKAGES="$PACKAGES helix"

# video
PACKAGES="$PACKAGES mpv mpv-mpris"

# day and night light
PACKAGES="$PACKAGES gammastep"

# notifications manager
PACKAGES="$PACKAGES dunst"

# mail client
PACKAGES="$PACKAGES thunderbird thunderbird-i18n-en-GB"

# torrent client
PACKAGES="$PACKAGES qbittorrent"

# pdf reader
PACKAGES="$PACKAGES zathura"

# proton mail bridge
PACKAGES="$PACKAGES pass libsecret libsecret-devel"

# vpn client
PACKAGES="$PACKAGES pass protonvpn-cli"

# anki
PACKAGES="$PACKAGES anki"

sudo xbps-install -Suy $PACKAGES

# install proton bridge from void-packages
# TODO: discord
