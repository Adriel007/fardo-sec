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
min_rssi=100  # Inicializar com um valor grande (positivo)

# Iterar sobre cada linha na saída
echo ----------------------------------------
while IFS= read -r line; do
    # Verificar se a linha contém o campo "ssid"
    if [[ $line == *"ssid"*]] then
        ssid=$(echo "$line" | awk -F'"' '{print $4}')  # Extrair o SSID
        rssi=$(echo "$line" | awk -F'"' '{print $8}')  # Extrair o RSSI

        # Calcular o valor absoluto do RSSI usando awk
        rssi_abs=$(awk -v rssi="$rssi" 'BEGIN {print int(rssi < 0 ? -rssi : rssi)}')
        echo "SSID: $ssid - RSSI: $rssi"
        # Atualizar o SSID com o valor de RSSI mais próximo de zero encontrado até agora
        if (( rssi_abs < min_rssi )); then
            min_rssi=$rssi_abs
            min_ssid=$ssid
        fi
    fi
done <<< "$wifi_info"
echo ---------------------------------------


echo "SSID com menor RSSI: $min_ssid"
