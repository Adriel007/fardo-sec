#!/data/data/com.termux/files/usr/bin/bash
FONT_GREEN="\e[32m"
FONT_RESET="\e[0m"
art=$(<$HOME/fardo-sec/art/interrogation.txt)

echo "$art"
read -p "Press ENTER to start GLITCH"

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

echo CTRL+C to exit

interface=$(ip route | awk '/default/ { print $5 }')

ip_network=$(ip route | awk '/default/ { print $3 }' | cut -d"." -f1-3)

while true; do
    ip_lastoctet=$(( $RANDOM % 254 + 1 ))
    new_ip="${ip_network}.${ip_lastoctet}"

    new_mac=$(openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//')

    su -c "ip addr flush dev $interface && ip addr add $new_ip/24 dev $interface && ip link set dev $interface down && ip link set dev $interface address $new_mac && ip link set dev $interface up"

    echo "Novo endereço IP: $new_ip"
    echo "Novo endereço MAC: $new_mac"

    sleep 5
done
