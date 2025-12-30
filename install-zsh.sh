#!/usr/bin/env bash

set -e

### CONFIG ###
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/dotfiles"
ZSHRC_SOURCE="$DOTFILES_DIR/zsh/.zshrc"
ZSHRC_TARGET="$HOME/.zshrc"

### HELPERS ###
log() {
  echo -e "\033[1;32m[INFO]\033[0m $1"
}

error() {
  echo -e "\033[1;31m[ERROR]\033[0m $1"
  exit 1
}

### 1. DETECT OS AND INSTALL ZSH ###
log "Detecting OS and installing zsh..."

if command -v zsh >/dev/null 2>&1; then
  log "zsh already installed"
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
      sudo apt install -y zsh git curl
      ;;
    fedora)
      sudo dnf install -y zsh git curl
      ;;
    arch)
      sudo pacman -Sy --noconfirm zsh git curl
      ;;
    *)
      error "Unsupported OS: $OS"
      ;;
  esac
fi

### 2. SET ZSH AS DEFAULT SHELL ###
if [[ "$SHELL" != "$(command -v zsh)" ]]; then
  log "Setting zsh as default shell"
  chsh -s "$(command -v zsh)"
else
  log "zsh is already default shell"
fi

### 3. INSTALL OH MY ZSH ###
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  log "Installing Oh My Zsh"
  RUNZSH=no KEEP_ZSHRC=yes sh -c \
    "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
  log "Oh My Zsh already installed"
fi

export ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

### 4. INSTALL POWERLEVEL10K ###
if [[ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]]; then
  log "Installing Powerlevel10k"
  git clone https://github.com/romkatv/powerlevel10k.git \
    "$ZSH_CUSTOM/themes/powerlevel10k"
else
  log "Powerlevel10k already installed"
fi

### 5. INSTALL PLUGINS ###
log "Installing zsh plugins"

if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions \
    "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

### 6. COPY .ZSHRC ###
if [[ ! -f "$ZSHRC_SOURCE" ]]; then
  error ".zshrc not found in $DOTFILES_DIR"
fi

log "Copying .zshrc"
cp "$ZSHRC_SOURCE" "$ZSHRC_TARGET"

### 7. APPLY CONFIG ###
log "Applying zsh config"
source "$ZSHRC_TARGET" || true

### 8. RUN P10K CONFIGURE ###
log "Starting Powerlevel10k configuration"
echo
echo "👉 After script finishes, run:"
echo "   exec zsh"
echo "   p10k configure"
echo

log "Done ✅"
