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

min_diff=999999  # Um número grande
min_ssid=""
min_rssi=""

# Iterar sobre cada linha na saída
while IFS= read -r line; do
    # Verificar se a linha contém o campo "ssid"
    if [[ $line == *"ssid"* ]]; then
        ssid=$(echo "$line" | awk -F'"' '{print $4}')  # Extrair o SSID
        rssi=$(echo "$line" | awk -F'"' '{print $8}')  # Extrair o RSSI

        # Calcular a diferença entre o RSSI e zero (valor absoluto)
        diff=${rssi#-}  # Remove o sinal negativo
        # Verificar se essa diferença é menor que a menor diferença encontrada até agora
        if ((diff < min_diff)); then
            min_diff=$diff
            min_ssid=$ssid
            min_rssi=$rssi
        fi
    fi
done <<< "$wifi_info"

echo "SSID com valor de RSSI mais próximo de zero:"
echo "SSID: $min_ssid"
echo "RSSI: $min_rssi"
