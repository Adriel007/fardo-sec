#!/data/data/com.termux/files/usr/bin/bash
FONT_GREEN="\e[32m"
FONT_RESET="\e[0m"

clear
echo -e "${FONT_RED}$(figlet Fardo - Sec)${FONT_RESET}"

echo -e "You can execute an shortcut with ${FONT_GREEN}fardo-sec${FONT_RESET}\n"
echo -e "You can update the fardo-sec with ${FONT_GREEN}fardo-sec --update${FONT_RESET}\n\n"

echo -e "${FONT_GREEN}Cameras${FONT_RESET}: Shortcut to acess traffic cameras."
echo -e "${FONT_GREEN}Sherlock${FONT_RESET}: Hunt down social media accounts by username across social networks."
echo -e "${FONT_GREEN}Mr.Holmes${FONT_RESET}: Mr.Holmes is a information gathering tool (OSINT)."
echo -e "${FONT_GREEN}SSH${FONT_RESET}: Connect to SSH servers."
echo -e "${FONT_GREEN}Swarm${FONT_RESET}: Multi-threaded DoS attack."
echo -e "${FONT_GREEN}Broker${FONT_RESET}: Router admin bruteforce + dictionary attack."
echo -e "${FONT_GREEN}Wlan-F${FONT_RESET}: Connect to a Wi-Fi network. with bruteforce and dictionary methods."
echo -e "${FONT_GREEN}Create Alias (shortcut)${FONT_RESET}: Create a custom shortcut in home directory."
echo -e "${FONT_GREEN}Update Alias (manually)${FONT_RESET}: Update aliases in home directory, sometimes you need to update to use new Alias."
