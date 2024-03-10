#!/data/data/com.termux/files/usr/bin/bash
FONT_GREEN="\e[32m"
FONT_RESET="\e[0m"
art=$(<$HOME/fardo-sec/art/interrogation.txt)

echo "$art"
read -p "Press ENTER to start GLITCH"

for i in {3..1}; do
    for ((j=0; j<4; j++)); do
        clear
        if [ $((j % 2)) -eq 0 ]; then
            echo -e "${FONT_RESET}$art"
        else
            echo -e "${FONT_GREEN}$art${FONT_RESET}"
        fi
        sleep 0.$i
    done
done

read -p "Press ENTER to continue..."