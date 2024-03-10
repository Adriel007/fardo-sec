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
# Executar a varredura Wi-Fi e armazenar a saída em wifi_info
wifi_info=$(termux-wifi-scaninfo)

# Inicializar os valores mínimos do RSSI e SSID
min_rssi=-100
min_ssid=""

# Iterar sobre cada objeto no resultado da varredura Wi-Fi
echo "$wifi_info" | jq -c '.[]' | while IFS= read -r obj; do
    ssid=$(echo "$obj" | jq -r '.ssid')
    rssi=$(echo "$obj" | jq -r '.rssi')
    if (( rssi >= min_rssi )); then
        min_rssi=$rssi
        min_ssid=$ssid
    fi
done

# Imprimir o resultado mínimo do RSSI e o SSID correspondente
echo "Minimum RSSI: $min_rssi"
echo "Corresponding SSID: $min_ssid"x