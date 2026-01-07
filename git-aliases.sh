#!/bin/bash

# Скрипт для добавления полезных алиасов в Git

echo "Добавляю Git алиасы..."

# Добавляем алиасы
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status

echo "Готово! Добавлены алиасы:"
echo "  git co  = checkout"
echo "  git br  = branch"
echo "  git ci  = commit"
echo "  git st  = status"

# Показываем все алиасы пользователя
echo -e "\nТекущие алиасы:"
git config --global --list | grep alias
