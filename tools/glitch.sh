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

interface=$(ip route | awk '$1 == "default" {print $5}')
echo "Interface de rede: $interface"

ip_address=$(ip -o -4 addr show $interface | awk '{print $4}')
subnet_mask=$(ip -o -4 addr show $interface | awk '{print $6}')
echo "IP e máscara de rede: $ip_address $subnet_mask"

generate_random_ip() {
    base_ip=$(echo $ip_address | cut -d'.' -f1-3)
    last_octet=$(shuf -i 2-254 -n 1)
    random_ip="$base_ip.$last_octet"
    echo "$random_ip"
}

generate_random_mac() {
    mac=$(printf '52:54:%02x:%02x:%02x:%02x\n' $[RANDOM%256] $[RANDOM%256] $[RANDOM%256] $[RANDOM%256])
    echo "$mac"
}

change_ip_and_mac() {
    random_ip=$(generate_random_ip)
    random_mac=$(generate_random_mac)

    echo "Alterando IP para: $random_ip"
    sudo ip addr flush dev $interface
    sudo ip addr add $random_ip$subnet_mask dev $interface

    echo "Alterando MAC para: $random_mac"
    sudo ip link set dev $interface down
    sudo ip link set dev $interface address $random_mac
    sudo ip link set dev $interface up
}

while true; do
    change_ip_and_mac
    sleep 10
done
