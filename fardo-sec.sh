echo "Starting..."

if ! [ -d "sherlock" ]; then
    echo "Installing..."

    #git clone https://github.com/sherlock-project/sherlock.git
    #python3 -m pip install -r ./sherlock/requirements.txt

    #echo "Installation finished"
fi

echo "Finishing..."

if ! grep -q "alias fardo-sec='./fardo-sec/fardo-sec.sh'" /data/data/com.termux/files/usr/etc/bash.bashrc; then
    echo "alias fardo-sec='./fardo-sec/fardo-sec.sh'" >> /data/data/com.termux/files/usr/etc/bash.bashrc
    source /data/data/com.termux/files/usr/etc/bash.bashrc
fi

echo "Finished"

FONT_GREEN="\e[32m"
FONT_RED="\e[31m"
FONT_RESET="\e[0m"

menu() {
    clear
    
    options=("Help" "Cameras" "Sherlock" "Mr.Holmes" "SSH" "Swarm" "Glitch" "Broker" "Wlan-F" "Create Alias (shortcut)" "Update Alias (manually)")
    commands=(
        "chmod +x ./tools/help.sh && ./tools/help.sh"
        "echo 'Você escolheu Cameras.'"
        "echo 'Você escolheu Sherlock.'"
        "echo 'Você escolheu Holmes.'"
        "echo 'Você escolheu SSH.'"
        "echo 'Você escolheu Swarm.'"
        "chmod +x ./tools/glitch.sh && ./tools/glitch.sh"
        "echo 'Broker choice'"
        "echo 'Wlan-F'"
        "echo 'clear && To create alias, scroll to bottom and write: && echo alias <name>=\"<command>\"' && sleep 3 && nano /data/data/com.termux/files/usr/etc/bash.bashrc"
        "source /data/data/com.termux/files/usr/etc/bash.bashrc && clear && echo Alias updated"
    )

    echo $(pwd)
    echo -e "${FONT_RED}$(figlet Fardo - Sec)${FONT_RESET}"
    echo "Tools:"
    for i in "${!options[@]}"; do
        echo -e "${FONT_GREEN}$((i+1))${FONT_RESET}) ${options[$i]}"
    done

    echo -e "\n${FONT_GREEN}0${FONT_RESET}) Exit"

    read -p "\n\nYour choice: " choice

    if [[ "$choice" -ge 1 && "$choice" -lt "${#options[@]}" ]]; then
        eval "${commands[$choice-1]}"
        read -p "Press ENTER to continue..."
        menu
    elif [[ "$choice" -eq 0 ]]; then
        clear
        exit 0
    else
        menu
    fi
}

menu