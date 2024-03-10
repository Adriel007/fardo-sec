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

# Obtém o SSID e o RSSI de cada rede Wi-Fi
while read -r line; do
    if [[ $line =~ "ssid" ]]; then
        ssid=$(echo "$line" | awk -F'"' '{print $4}')
    elif [[ $line =~ "rssi" ]]; then
        rssi=$(echo "$line" | awk -F'[- ]' '{print $2}')
        # Verifica se o RSSI é o mais forte até agora
        if (( rssi > max_rssi )); then
            max_rssi=$rssi
            strongest_ssid=$ssid
        fi
    fi
done <<< "$wifi_info"

# Exibe o Wi-Fi mais próximo
echo "Wi-Fi mais próximo: $strongest_ssid com RSSI $max_rssi"