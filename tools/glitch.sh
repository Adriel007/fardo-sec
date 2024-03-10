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


# Obtém a interface de rede padrão
interface=$(ip route | grep default | awk '{print $5}')

# Obtém o endereço IP e a máscara de sub-rede atual usando ifconfig
ip_info=$(ifconfig $interface | grep "inet " | awk '{print $2}')
ip=$(echo $ip_info | cut -d' ' -f2)
subnet_mask=$(echo $ip_info | cut -d' ' -f4)

# Determina o prefixo da rede
case $subnet_mask in
    255.0.0.0)
        prefix="8"
        ;;
    255.255.0.0)
        prefix="16"
        ;;
    255.255.255.0)
        prefix="24"
        ;;
    *)
        echo "Subnet mask não suportada."
        exit 1
        ;;
esac

# Gera um IP aleatório na mesma rede
random_ip=$(awk -v ip="$ip" -v prefix="$prefix" '
    BEGIN {
        split(ip, octets, ".");
        srand();
        for (i = 1; i <= 4; i++) {
            if (i <= prefix / 8) {
                new_ip = new_ip octets[i] ".";
            } else if (i == int(prefix / 8) + 1) {
                new_ip = new_ip int(rand() * 256) ".";
            } else {
                new_ip = new_ip int(rand() * 256);
            }
        }
        print new_ip;
    }
')

# Define o novo IP
ip addr add $random_ip/$subnet_mask dev $interface

echo "Novo IP configurado: $random_ip/$subnet_mask"