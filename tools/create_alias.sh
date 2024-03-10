FONT_RED="\e[31m"
FONT_RESET="\e[0m"

clear 
echo "To create an alias, scroll to the bottom and write:"
echo "alias <name>=\"<command>\""
echo -e "\n${FONT_GREEN}BE CAREFUL, DO NOT DELETE OTHER LINES${FONT_RESET}"
read -p "Press ENTER to continue..."
nano /data/data/com.termux/files/usr/etc/bash.bashrc"