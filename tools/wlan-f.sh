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

# Loop sobre as informações das redes Wi-Fi
while IFS= read -r line; do
    if [[ $line =~ ^SSID:\ ([^\"]+) ]]; then
        ssid="${BASH_REMATCH[1]}"
    elif [[ $line =~ ^RSSI:\ ([^\"]+) ]]; then
        rssi="${BASH_REMATCH[1]}"
        if (( rssi > max_rssi )); then
            max_rssi=$rssi
            strongest_signal="$ssid"
        fi
    fi
done <<< "$wifi_info"

# Exibe o nome da rede com o sinal mais forte
echo "Rede Wi-Fi mais próxima: $strongest_signal com RSSI $max_rssi"