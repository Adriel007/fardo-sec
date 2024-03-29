#!/data/data/com.termux/files/usr/bin/bash
echo "Starting..."

if [$1 == "--update"]; then
    echo "Updating..."
    cd $HOME/fardo-sec
    git reset --hard
    git pull
    chmod +x ./fardo-sec.sh
    ./fardo-sec.sh
    exit 0
fi

if [$1 == "--install"]; then
    echo "Installing..."
    chmod +x $HOME/fardo-sec/install.sh
    $HOME/fardo-sec/install.sh
fi

if ! [ -d "sherlock" ]; then
    git clone https://github.com/sherlock-project/sherlock.git
    python3 -m pip install -r $HOME/fardo-sec/sherlock/requirements.txt
fi

if ! [ -d "Mr.Holmes" ]; then
    git clone https://github.com/Lucksi/Mr.Holmes
    cd Mr.Holmes
    proot -0 chmod +x install_Termux.sh
    ./install_Termux.sh
fi

echo "Finishing..."

if ! grep -q "alias fardo-sec='$HOME/fardo-sec/fardo-sec.sh'" /data/data/com.termux/files/usr/etc/bash.bashrc; then
    echo "alias fardo-sec='$HOME/fardo-sec/fardo-sec.sh'" >> /data/data/com.termux/files/usr/etc/bash.bashrc
    source /data/data/com.termux/files/usr/etc/bash.bashrc
fi

echo "Creating Widgets..."

scripts=(
    "$HOME/fardo-sec/tools/wlan-f.sh:~/.shortcuts/wlan-f.sh",
    
)

for mapping in "${scripts[@]}"; do
    script_path="${mapping%%:*}"
    shortcut_path="${mapping##*:}"

    echo "$script_path" > "$shortcut_path"
    chmod +x "$shortcut_path"

    echo "Created shortcut for $script_path at $shortcut_path"
done

echo "Giving permission to execute..."
chmod +x $HOME/fardo-sec/animation.sh
chmod +x $HOME/fardo-sec/tools/help.sh 
chmod +x $HOME/fardo-sec/tools/wlan-f.sh
chmod +x $HOME/fardo-sec/tools/create_alias.sh

echo "Finished"

FONT_GREEN="\e[32m"
FONT_RED="\e[31m"
FONT_RESET="\e[0m"

menu() {
    clear
    
    options=("Help" "CCTV" "Sherlock" "Mr.Holmes" "SSH" "Swarm" "Broker" "Wlan-F" "Create Alias (shortcut)" "Update Alias (manually)")
    commands=(
        "$HOME/fardo-sec/tools/help.sh"
        "echo 'Você escolheu Cameras.'"
        "echo 'Você escolheu Sherlock.'"
        "echo 'Você escolheu Holmes.'"
        "echo 'Você escolheu SSH.'"
        "echo 'Você escolheu Swarm.'"
        "echo 'Broker choice'"
        "$HOME/fardo-sec/tools/wlan-f.sh"
        "$HOME/fardo-sec/tools/create_alias.sh"
        "source /data/data/com.termux/files/usr/etc/bash.bashrc && clear && echo Alias updated"
    )

    echo -e "${FONT_RED}$(figlet Fardo - Sec)${FONT_RESET}"
    echo "Tools:"
    for i in "${!options[@]}"; do
        echo -e "${FONT_GREEN}$((i+1))${FONT_RESET}) ${options[$i]}"
    done

    echo -e "\n${FONT_GREEN}0${FONT_RESET}) Exit\n\n"
    read -p "Your choice: " choice

    if [[ "$choice" -ge 1 && "$choice" -lt "${#options[@]}" ]]; then
        eval "${commands[$choice-1]}"
        if [ "$keyboard" -eq 1 ]; then
            sleep 2
        fi
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

#todo:
######################################################
#nmap

#tor

#apache2

#art is loading screen
######################################################
