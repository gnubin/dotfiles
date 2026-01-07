#!/bin/bash

### Объявление переменных окружения для пуетй файлов конфигураци ###
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"  # Директория исполнения скрипта
DOTFILES_DIR="$SCRIPT_DIR"                                  # Абсолютный путь к директории dotfiles

### Функции логирования ###
log() {
  echo -e "\033[1;32m[INFO]\033[0m $1"
}

error() {
  echo -e "\033[1;31m[ERROR]\033[0m $1"
  exit 1
}

### 1. Определение ОС и установка git ###
# Проверка установлен ли git
if command -v git >/dev/null 2>&1; then
  log "Git уже установлен"
else
# Определение ОС и установка git через стандартный пакетный менеджер
 if [[ -f /etc/os-release ]]; then
    . /etc/os-release
    OS=$ID
  else
    error "Не удалось определить ОС"
  fi

  case "$OS" in
    ubuntu|debian)
      sudo apt update
      sudo apt install -y git curl
      ;;
    fedora)
      sudo dnf install -y git curl
      ;;
    arch)
      sudo pacman -Sy --noconfirm git curl
      ;;
    *)
      error "Не поддерживается ОС: $OS (утановите git вручную)"
      ;;
  esac
fi


### 2. Добавления полезных алиасов в git

log "Добавляю Git алиасы..logбавляем алиасы"

git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status

log "Готово! Добавлены алиасы:"

log "  git co  = checkout"
log "  git br  = branch"
log "  git ci  = commit"
log "  git st  = status"

# Показываем все алиасы пользователя
log "Текущие алиасы:"

git config --global --list | grep alias


