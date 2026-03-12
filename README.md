# Описание
Репозиторий содержит конфигурационные файлы для настроки рабочего окружения.
Автоматическая установка и настройка необходимых зависимостей производится через bash скрипты.

# Настройка рабочего окружения
1. Склонируйте репозиторий dotfiles
```bash
git clone https://github.com/gnubin/dotfiles.git
```
## Установка и настрока zsh
для установки и настройки zsh запутите скрип install-zsh.sh командой

```bash
./dotfiles/install-zsh.sh
```
## Установка и настрока alacritty
для установки и настройки alacritty запутите скрип install-alacritty.sh командой

```bash
./dotfiles/install-alacritty.sh
```
nix
curl
Obsidian
KeepassXC

изменить каплок на контрл
Через системный конфигурационный файл

Этот способ подойдет, если у вас нет GNOME Tweaks или вы хотите настроить параметры глобально для всех пользователей на уровне системы.

    Отредактируйте файл /etc/default/keyboard с правами администратора. Например, с помощью редактора nano:
    bash

sudo nano /etc/default/keyboard

Найдите строку, начинающуюся с XKBOPTIONS. Если её нет, добавьте её. Установите следующее значение:
text

XKBOPTIONS="ctrl:nocaps"

Эта опция полностью отключает Caps Lock и превращает его в дополнительный Ctrl

    .

Сохраните файл (в nano: Ctrl+O, затем Enter) и выйдите (Ctrl+X).

Примените изменения одной из команд:
bash

sudo dpkg-reconfigure keyboard-configuration
# или
sudo udevadm trigger --subsystem-match=input --action=change

После этого рекомендуется перезагрузить компьютер, чтобы изменения гарантированно вступили в силу .
