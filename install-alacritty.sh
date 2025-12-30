#!/bin/bash

### CONFIGS ###
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$SCRIPT_DIR"
ALACRITTY_SOURCE="$DOTFILES_DIR/alacritty/alacritty.toml"
ALACRITTY_TARGET="$HOME/.alacritty.toml"

### HELPERS ###
log() {
  echo -e "\033[1;32m[INFO]\033[0m $1"
}

error() {
  echo -e "\033[1;31m[ERROR]\033[0m $1"
  exit 1
}

### 1. DETECT OS AND INSTALL ALACRITTY ###
if command -v alacritty >/dev/null 2>&1; then
  log "alacritty already installed"
else
 if [[ -f /etc/os-release ]]; then
    . /etc/os-release
    OS=$ID
  else
    error "Cannot detect OS"
  fi

  case "$OS" in
    ubuntu|debian)
      sudo apt update
      sudo apt install -y alacritty git curl
      ;;
    fedora)
      sudo dnf install -y alacritty git curl
      ;;
    arch)
      sudo pacman -Sy --noconfirm alacritty git curl
      ;;
    *)
      error "Unsupported OS: $OS"
      ;;
  esac
fi


