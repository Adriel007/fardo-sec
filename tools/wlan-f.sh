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

min_ssid=""
min_rssi=0  # Inicializar com um valor pequeno (positivo)

# Iterar sobre cada linha na saída
while IFS= read -r line; do
    # Verificar se a linha contém o campo "ssid"
    if [[ $line == *"ssid"* && $line != *"bssid"* ]]; then
        ssid=$(echo "$line" | awk -F'"' '{print $4}')  # Extrair o SSID
        rssi=$(echo "$line" | awk -F'"' '{print $8}')  # Extrair o RSSI

        # Atualizar o SSID com o valor de RSSI mais negativo encontrado até agora
        if (( rssi < min_rssi )); then
            min_rssi=$rssi
            min_ssid=$ssid
        fi
    fi
done <<< "$wifi_info"


echo "SSID com menor RSSI: $min_ssid"
