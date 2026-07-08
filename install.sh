#!/bin/bash
set -e

# 1. Base
sudo dnf install -y git dnf-plugins-core

# 2. Dotfiles PRIMERO (bare repo) — puebla .myetc, .local, .config, etc.
git clone --bare git@github.com:ernestosavio/dotfiles.git "$HOME/.dotfiles"
function config { /usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" "$@"; }
mkdir -p "$HOME/.dotfiles-backup"
config checkout || (config checkout 2>&1 | grep -E "^\s+\." | awk '{print $1}' | xargs -I{} mv "$HOME/{}" "$HOME/.dotfiles-backup/{}"; config checkout)
config config status.showUntrackedFiles no

# 3. dcli vía COPR
sudo dnf copr enable theblackdon/dcli -y
sudo dnf install -y dcli

# 4. dcli-config: instala TODO lo de dnf + copia hooks para `udev rules` y `/etc`
git clone git@github.com:ernestosavio/dcli-config.git ~/.config/dcli
echo "host: main" > ~/.config/dcli/config.yaml # Replace "main" for the real host
cd ~/.config/dcli-config
dcli sync

# 5. nix-config: ex-AUR y privativos
git clone git@github.com:ernestosavio/nix-config.git ~/nix-config
cd ~/nix-config
nix run home-manager/master -- init --switch --flake ~/nix-config#$(whoami) --impure

echo "✓ Sistema completo. Rebootear."
