#!/bin/bash

# Определение цветов
RED="\033[1;31m"
GREEN="\033[1;32m"
BLUE="\033[1;34m"
YELLOW="\033[1;33m"
MAGENTA="\033[1;35m"
RESET="\033[0m"

# Очистка терминала
clear

# Баннер с цветами
echo -e "${MAGENTA} _  _ _____   __  _____ ___   _   __  __${RESET}"
echo -e "${MAGENTA}| || | _ \\ \\ / /_|_   _| __| /_\\ |  \\/  |${RESET}"
echo -e "${MAGENTA}| __ |  _/\\ V /___|| | | _| / _ \\| |\\/| |${RESET}"
echo -e "${MAGENTA}|_||_|_|   \\_/     |_| |___/_/ \\_\\_|  |_|${RESET}"
echo -e "${MAGENTA}+-----------------------------------------+${RESET}"
echo -e "${MAGENTA}| Контент: t.me/HPV_TEAM /// t.me/HPV_PRO |${RESET}"
echo -e "${MAGENTA}+-----------------------------------------+${RESET}"
echo -e "${MAGENTA}| Сотрудничество: t.me/HPV_BASE |${RESET}"
echo -e "${MAGENTA}+-------------------------------+${RESET}"
echo -e "${MAGENTA}| Автор: t.me/A_KTO_Tbl |${RESET}"
echo -e "${MAGENTA}+-----------------------+${RESET}"

# Проверка наличия утилиты expect
if ! command -v expect &> /dev/null; then
    echo -e "\n${BLUE}Установка \`expect\` для автоматизации ввода...${RESET}"
    pkg install -y expect > /dev/null 2>&1
    echo -e "${GREEN}Установка \`expect\` завершена.${RESET}"
fi

# Настройка зеркал репозиториев
echo -e "\n${BLUE}Настройка зеркал репозиториев...${RESET}"
expect <<EOF > /dev/null 2>&1
spawn termux-change-repo
sleep 1
send "\r"
sleep 1
send "\r"
expect eof
EOF
echo -e "${GREEN}Настройка зеркал репозиториев завершена.${RESET}"

# Функция для установки пакетов с автоматическим подтверждением
install_package() {
    for package in "$@"; do
        echo -e "\t${YELLOW}Установка $package...${RESET}"
        yes | pkg install "$package" > /dev/null 2>&1 || {
            echo -e "\t\t${RED}Ошибка при установке $package. Повторная попытка...${RESET}"
            yes | pkg install "$package" > /dev/null 2>&1
        }
        echo -e "\t\t${GREEN}$package успешно установлен.${RESET}"
    done
}

# Обновление и установка необходимых пакетов
echo -e "\n${BLUE}Обновление пакетов...${RESET}"
yes | pkg update > /dev/null 2>&1
yes | pkg upgrade > /dev/null 2>&1
echo -e "${GREEN}Пакеты обновлены.${RESET}"

echo -e "\n${BLUE}Установка зависимостей...${RESET}"
install_package tsu python git root-repo x11-repo wpa-supplicant pixiewps iw

# Настройка доступа к хранилищу
echo -e "\n${BLUE}Настройка доступа к хранилищу...${RESET}"
yes | termux-setup-storage > /dev/null 2>&1
echo -e "${YELLOW}Пожалуйста, разрешите доступ в появившемся окне!${RESET}"

# Клонирование репозитория и подготовка
echo -e "\n${BLUE}Клонирование репозитория OneShot...${RESET}"
git clone https://github.com/HPV-CLOUD/OneShot > /dev/null 2>&1
chmod +x OneShot/oneshot.py

# Сообщение об успешной установке
echo -e "\n${GREEN}🎉 Всё готово! Утилита OneShot установлена и подготовлена.${RESET}"
echo -e "\nДля запуска выполните следующую команду:"
echo -e "${BLUE}sudo python ~/OneShot/oneshot.py -i wlan0 --iface-down -K\n${RESET}"
