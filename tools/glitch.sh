#!/data/data/com.termux/files/usr/bin/bash
FONT_GREEN="\e[32m"
FONT_RESET="\e[0m"
art=$(<$HOME/fardo-sec/art/interrogation.txt)

echo "$art"
read -p "Press ENTER to start GLITCH"

for i in {9..1}; do
    clear
    if [ $((i % 2)) -eq 0 ]; then
        echo -e "${FONT_GREEN}$art${FONT_RESET}"
    else
        echo -e "${FONT_RESET}$art"
    fi
    sleep 0.$i
done

read -p "Press ENTER to continue..."