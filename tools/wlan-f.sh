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

min_rssi=-100
min_ssid=""

# Iterar sobre cada entrada no JSON
while IFS= read -r line; do
    ssid=$(echo "$line" | grep -oP '(?<="ssid": ")[^"]+')
    rssi=$(echo "$line" | grep -oP '(?<="rssi": )[^,]+')

    # Atualizar o SSID com o menor valor de RSSI encontrado até agora
    if (( rssi < min_rssi )); then
        min_rssi=$rssi
        min_ssid=$ssid
    fi
done <<< "$wifi_info"

# Imprimir o SSID com o menor valor de RSSI
echo "SSID com menor RSSI: $min_ssid"