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

# Função para obter o prefixo da rede
get_network_prefix() {
    local ip=$(ip route | grep default | awk '{print $3}')
    local mask=$(ifconfig | grep -A 1 "$ip" | tail -n 1 | awk '{print $4}')
    local prefix=$(echo "$mask" | tr '.' ' ' | awk '{print $1}')
    echo "$prefix"
}

# Função para gerar um IP aleatório com base no prefixo da rede
generate_random_ip() {
    local prefix="$1"
    case "$prefix" in
        10)
            echo "10.$((RANDOM % 256)).$((RANDOM % 256)).$((RANDOM % 254 + 1))"
            ;;
        172)
            echo "172.$((RANDOM % 16 + 16)).$((RANDOM % 256)).$((RANDOM % 254 + 1))"
            ;;
        192)
            echo "192.168.$((RANDOM % 256)).$((RANDOM % 254 + 1))"
            ;;
        *)
            echo "Prefixo de rede não suportado"
            ;;
    esac
}

# Obter a interface de rede padrão
interface=$(ip route | grep default | awk '{print $5}')

# Loop infinito para alterar o IP
while true; do
    prefix=$(get_network_prefix)
    new_ip=$(generate_random_ip "$prefix")
    echo "Configurando novo IP: $new_ip"
    ip addr flush dev "$interface"
    ip addr add "$new_ip"/24 dev "$interface"
    sleep 60  # Altera o IP a cada 60 segundos
done