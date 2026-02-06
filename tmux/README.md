# Описание
- tmux (terminal multiplexer) — это консольная утилита, позволяющая управлять множеством терминальных сессий в одном окне, разделять экран на панели и сохранять запущенные процессы при отключении SSH-сессии

- tpm (tmux plugin manager) — это основной инструмент для управления плагинами в tmux. Он позволяет автоматизировать установку, обновление и удаление расширений через конфигурационный файл.
С актуальной инструкцию по установке, настройке и использованию можно ознаомиться здесь https://github.com/tmux-plugins/tpm

# Установка tmux
```bash
## Ubuntu/Debian 
sudo apt install tmux
```
# Установка и настройка tmp
- Клонируем github репзиторий с tmp
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
- Копируем готовый конфигурационный файл `.tmux.conf` 
```bash
cp ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
```
- Заходим в tmux и применяем настройки
```bash
tmux
# Ctrl+a I
```

