#!/data/data/com.termux/files/usr/bin/bash
clear
FONT_GREEN="\e[32m"
FONT_RESET="\e[0m"
art=$(<$HOME/fardo-sec/art/wifi.txt)

echo "$art"
read -p "Press ENTER to continue..."

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

termux-wifi-enable true

wifi_info=$(termux-wifi-scaninfo)

# Inicializa as variáveis para armazenar o nome e o RSSI da rede mais forte
strongest_signal=""
max_rssi=-100

# Extrai SSID e RSSI de cada rede Wi-Fi na saída do comando
while read -r ssid; do
    read -r rssi
    if (( rssi > max_rssi )); then
        max_rssi=$rssi
        strongest_signal="$ssid"
    fi
done < <(echo "$wifi_info" | jq -r '.[].ssid, .[].rssi')

# Exibe o nome da rede com o sinal mais forte
echo "Rede Wi-Fi mais próxima: $strongest_signal com RSSI $max_rssi"