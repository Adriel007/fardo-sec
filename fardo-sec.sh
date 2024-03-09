echo "Starting..."

echo pwd

sleep 10
if ! [ -d "sherlock" ]; then
    echo "Installing..."

    #git clone https://github.com/sherlock-project/sherlock.git
    #cd sherlock
    #python3 -m pip install -r requirements.txt
    #cd ..

    #echo "Installation finished"
    #cd ..
fi

echo "Finishing..."

if ! grep -q "alias fardo-sec='./fardo-sec/fardo-sec.sh'" /data/data/com.termux/files/usr/etc/bash.bashrc; then
    echo "alias fardo-sec='./fardo-sec/fardo-sec.sh'" >> /data/data/com.termux/files/usr/etc/bash.bashrc
fi

echo "Finished"

FONT_GREEN="\e[32m"
FONT_RED="\e[31m"
FONT_RESET="\e[0m"

menu() {
    clear
    
    options=("Help" "Cameras" "Sherlock" "Mr.Holmes" "SSH" "Swarm" "Glitch" "Broker" "Wlan-F" "Create Alias (shortcut)" "Update Alias (manually)")
    commands=(
        "chmod +x ./fardo-sec/tools/help.sh && ./fardo-sec/tools/help.sh"
        "echo 'Você escolheu Cameras.'"
        "echo 'Você escolheu Sherlock.'"
        "echo 'Você escolheu Holmes.'"
        "echo 'Você escolheu SSH.'"
        "echo 'Você escolheu Swarm.'"
        "chmod +x ./fardo-sec/tools/glitch.sh && ./fardo-sec/tools/glitch.sh"
        "echo 'Broker choice'"
        "echo 'Wlan-F'"
        "echo 'clear && To create alias, scroll to bottom and write: && echo alias <name>=\"<command>\"' && sleep 3 && nano /data/data/com.termux/files/usr/etc/bash.bashrc"
        "source /data/data/com.termux/files/usr/etc/bash.bashrc && clear && echo Alias updated"
    )

    echo -e "${FONT_RED}$(figlet Fardo - Sec)${FONT_RESET}"
    echo "Tools:"
    for i in "${!options[@]}"; do
        echo -e "${FONT_GREEN}$((i+1))${FONT_RESET}) ${options[$i]}"
    done

    echo -e "${FONT_GREEN}0${FONT_RESET}) Exit"

    read -p "Your choice: " choice

    if [[ "$choice" -ge 1 && "$choice" -lt "${#options[@]}" ]]; then
        eval "${commands[$choice-1]}"
        read -p "Press enter to continue..."
        menu
    elif [[ "$choice" -eq 0 ]]; then
        cd ..
        clear
        exit 0
    else
        menu
    fi
}

menu