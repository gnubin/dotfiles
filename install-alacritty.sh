#!/bin/bash

### Объявление переменных окружения для пуетй файлов конфигураци ###
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"  # Директория исполнения скрипта
DOTFILES_DIR="$SCRIPT_DIR"                                  # Абсолютный путь к директории dotfiles
ALACRITTY_SOURCE="$DOTFILES_DIR/alacritty/.alacritty.toml"  #  Абсолютный путь к файлу .alacritty.toml
ALACRITTY_TARGET="$HOME/.alacritty.toml"                    #  Абсолютный путь к файлу alacritty.toml в системе 

### Функции логирования ###
log() {
  echo -e "\033[1;32m[INFO]\033[0m $1"
}

error() {
  echo -e "\033[1;31m[ERROR]\033[0m $1"
  exit 1
}

### 1. Определение ОС и установка alacritty ###
# Проверка установлен ли alacritty
if command -v alacritty >/dev/null 2>&1; then
  log "alacritty already installed"
else
# Определение ОС и установка alacritty через стандартный пакетный менеджер
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

### 2. Копирование готового файла конфигурации alacritty.toml ###
if [[ ! -f "$ALACRITTY_SOURCE" ]]; then
  error ".alacritty.toml not found in $DOTFILES_DIR"
fi

log "Copying .alacritty.toml"
cp "$ALACRITTY_SOURCE" "$ALACRITTY_TARGET"

### 3. Применение конфигурации ###
log "Restart Alacritty to apply config"
log "Done"
