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

# Extrair o maior RSSI próximo de 0 e o SSID correspondente
max_rssi=0
max_ssid=""
for row in $(echo "${wifi_info}" | jq -c '.[]'); do
    ssid=$(echo "${row}" | jq -r '.ssid')
    rssi=$(echo "${row}" | jq -r '.rssi')
    abs_rssi=${rssi#-}  # remove o sinal negativo
    if [ "${abs_rssi}" -lt "${max_rssi}" ]; then
        max_rssi="${abs_rssi}"
        max_ssid="${ssid}"
    fi
done

# Exibir o maior RSSI próximo de 0 e o SSID correspondente na tela
echo "Maior RSSI próximo de 0: -${max_rssi}"
echo "SSID correspondente: ${max_ssid}"