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

# Função para obter o endereço IP da interface de rede padrão
get_ip_address() {
    local interface=$(netstat -rn | grep -E '^(default|0\.0\.0\.0)' | awk '{print $NF}')
    ifconfig "$interface" | awk '/inet /{print $2}'
}

# Função para gerar um IP aleatório com base no prefixo da rede
generate_random_ip() {
    local ip=$(get_ip_address)
    local prefix=$(echo "$ip" | cut -d'.' -f1)
    case "$prefix" in
        10) echo "10.$((RANDOM % 256)).$((RANDOM % 256)).$((RANDOM % 254 + 1))" ;;
        172) echo "172.$((RANDOM % 16 + 16)).$((RANDOM % 256)).$((RANDOM % 254 + 1))" ;;
        192) echo "192.168.$((RANDOM % 256)).$((RANDOM % 254 + 1))" ;;
        *) echo "Prefixo de rede não suportado" ;;
    esac
}

# Loop infinito para alterar o IP
while true; do
    new_ip=$(generate_random_ip)
    echo "Configurando novo IP: $new_ip"
    ifconfig wlan0 "$new_ip" netmask 255.255.255.0
    sleep 60  # Altera o IP a cada 60 segundos
done