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

# Filtra apenas o SSID e o RSSI das redes
wifi_list=$(echo "$wifi_info" | grep -E '^SSID:|^RSSI:' | awk -F': ' '{print $2}')

# Inicializa as variáveis para armazenar o nome e o RSSI da rede mais forte
strongest_signal=""
max_rssi=-100

# Loop sobre as informações das redes Wi-Fi
while IFS= read -r line; do
    if [[ $line =~ ^SSID: ]]; then
        ssid="${line#SSID: }"
    elif [[ $line =~ ^RSSI: ]]; then
        rssi="${line#RSSI: }"
        if (( rssi > max_rssi )); then
            max_rssi=$rssi
            strongest_signal="$ssid"
        fi
    fi
done <<< "$wifi_list"

# Exibe o nome da rede com o sinal mais forte
echo "Rede Wi-Fi mais próxima: $strongest_signal com RSSI $max_rssi"